import json
import os
import sys

# --- HELPER FUNCTION TO LOAD JSON ---
def load_json_objects(filepath):
    """
    Reads a JSON file and returns a list of objects.
    Handles both standard JSON and the one-object-per-line format.
    Returns an empty list on error.
    """
    if not os.path.exists(filepath):
        print(f"Hata: '{filepath}' dosyası bulunamadı.")
        return []

    objects = []
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            if not content.strip() or content.strip() in ['[]', '{}']:
                return []
            try:
                objects = json.loads(content)
                if not isinstance(objects, list):
                    print(f"Uyarı: '{filepath}' içindeki JSON bir liste değil.")
                    return []
            except json.JSONDecodeError:
                lines = content.strip().split('\n')
                object_lines = [line.strip().rstrip(',') for line in lines if line.strip().startswith('{')]
                for line in object_lines:
                    try:
                        objects.append(json.loads(line))
                    except json.JSONDecodeError:
                        print(f"Uyarı: '{filepath}' dosyasında geçersiz bir satır atlanıyor -> {line}")
    except Exception as e:
        print(f"Hata: '{filepath}' dosyası okunurken bir sorun oluştu: {e}")
        return []
        
    return objects

# --- DEDUPLICATION FUNCTION ---
def deduplicate_file(filepath):
    """
    Reads a JSON file, removes duplicate objects, and overwrites the original file
    after creating a backup.
    """
    print("-" * 40)
    print(f"Duplikasyon kontrolü yapılıyor: {filepath}")

    backup_path = filepath + ".bak"
    try:
        if os.path.exists(filepath):
            os.replace(filepath, backup_path)
            print(f"Güvenlik için yedek oluşturuldu: {backup_path}")
        else:
            print(f"Uyarı: '{filepath}' dosyası mevcut değil, duplikasyon kontrolü atlanıyor.")
            return
    except OSError as e:
        print(f"Hata: Yedek dosyası oluşturulamadı. {e}")
        return

    objects = load_json_objects(backup_path)
    if not objects:
        print("Dosyada işlenecek veri bulunamadı. Dosya orijinal haline getiriliyor.")
        if os.path.exists(backup_path): os.replace(backup_path, filepath)
        return

    seen_objects = set()
    unique_objects = []
    for obj in objects:
        canonical_form = json.dumps(obj, sort_keys=True, ensure_ascii=False)
        if canonical_form not in seen_objects:
            seen_objects.add(canonical_form)
            unique_objects.append(obj)
            
    duplicates_found = len(objects) - len(unique_objects)
    if duplicates_found > 0:
        print(f"Başarılı: {duplicates_found} adet mükerrer kayıt bulundu ve silindi.")
        print(f"Eski kayıt sayısı: {len(objects)}, Yeni kayıt sayısı: {len(unique_objects)}")
    else:
        print("Mükerrer kayıt bulunamadı.")

    try:
        with open(filepath, 'w', encoding='utf-8') as f:
            if not unique_objects:
                f.write("[]")
            else:
                f.write("[\n")
                f.write(",\n".join(json.dumps(obj, ensure_ascii=False) for obj in unique_objects))
                f.write("\n]")
        print(f"'{filepath}' dosyası güncellendi.")
    except Exception as e:
        print(f"Hata: Temizlenmiş dosya yazılırken sorun oluştu: {e}")
        print("Değişiklikler geri alınıyor...")
        if os.path.exists(backup_path): os.replace(backup_path, filepath)

# --- CORRECTED VERIFICATION FUNCTION (RECIPES -> CHARACTERS) ---
def verify_and_save_missing_components(recipes_filepath, characters_filepath, missing_filepath):
    """
    Checks if all 'inputs' AND 'outputs' in recipes exist as 'char' in characters.
    Reports and saves any missing components to a JSON file.
    """
    print("-" * 40)
    print(f"Doğrulama 1 (Düzeltilmiş): Tüm tarif bileşenleri (girdi VE çıktı) karakter listesinde var mı?")

    character_objects = load_json_objects(characters_filepath)
    if not character_objects:
        print("Karakter listesi yüklenemediği için doğrulama yapılamıyor.")
        return
    valid_chars = {entry['char'] for entry in character_objects if 'char' in entry}
    
    recipe_objects = load_json_objects(recipes_filepath)
    if not recipe_objects:
        print("Tarif listesi yüklenemediği için doğrulama yapılamıyor.")
        return

    missing_components = set()
    for recipe in recipe_objects:
        # Check inputs
        if 'inputs' in recipe and isinstance(recipe['inputs'], list):
            for component in recipe['inputs']:
                if component not in valid_chars:
                    missing_components.add(component)
        # *** NEW: Check the output as well ***
        if 'output' in recipe:
            if recipe['output'] not in valid_chars:
                missing_components.add(recipe['output'])
    
    if not missing_components:
        print("✅ Doğrulama Başarılı: Tüm tarif bileşenleri (girdiler ve çıktılar) 'characters.json' içinde mevcut.")
    else:
        print(f"⚠️ Doğrulama Uyarısı: {len(missing_components)} adet eksik bileşen bulundu.")
        print("Bu bileşenler tariflerde kullanılıyor ancak 'characters.json' listesinde tanımlı değil.")
        
        sorted_missing = sorted(list(missing_components))
        print(f"Eksik Bileşenler: {sorted_missing}")

        try:
            with open(missing_filepath, 'w', encoding='utf-8') as f:
                json.dump(sorted_missing, f, ensure_ascii=False, indent=2)
            print(f"✅ Eksik bileşen listesi '{missing_filepath}' dosyasına kaydedildi.")
        except Exception as e:
            print(f"HATA: '{missing_filepath}' dosyası yazılırken bir sorun oluştu: {e}")

# --- VERIFICATION FUNCTION (CHARACTERS -> RECIPES) ---
def find_unused_characters(recipes_filepath, characters_filepath, unused_filepath):
    """
    Checks for characters in 'characters.json' that are never used in any recipe.
    """
    print("-" * 40)
    print(f"Doğrulama 2: Tanımlı karakterlerden kullanılmayan var mı?")

    character_objects = load_json_objects(characters_filepath)
    if not character_objects:
        print("Karakter listesi yüklenemediği için kontrol yapılamıyor.")
        return
    all_defined_chars = {entry['char'] for entry in character_objects if 'char' in entry}
    print(f"Toplam tanımlı karakter sayısı: {len(all_defined_chars)}")

    recipe_objects = load_json_objects(recipes_filepath)
    if not recipe_objects:
        print("Tarif listesi yüklenemediği için kontrol yapılamıyor.")
        return

    all_used_chars = set()
    for recipe in recipe_objects:
        if 'output' in recipe:
            all_used_chars.add(recipe['output'])
        if 'inputs' in recipe and isinstance(recipe['inputs'], list):
            all_used_chars.update(recipe['inputs'])
    print(f"Tariflerde kullanılan toplam eşsiz karakter sayısı: {len(all_used_chars)}")

    unused_chars = all_defined_chars.difference(all_used_chars)
    
    if not unused_chars:
        print("✅ Kontrol Başarılı: 'characters.json' içindeki tüm karakterler tariflerde kullanılıyor.")
    else:
        print(f"⚠️ Bilgi: {len(unused_chars)} adet karakter 'characters.json' içinde tanımlı ancak hiçbir tarifte kullanılmıyor.")
        sorted_unused = sorted(list(unused_chars))
        print(f"Kullanılmayan Karakterler: {sorted_unused}")
        try:
            with open(unused_filepath, 'w', encoding='utf-8') as f:
                json.dump(sorted_unused, f, ensure_ascii=False, indent=2)
            print(f"✅ Kullanılmayan karakter listesi '{unused_filepath}' dosyasına kaydedildi.")
        except Exception as e:
            print(f"HATA: '{unused_filepath}' dosyası yazılırken bir sorun oluştu: {e}")

# --- MAIN EXECUTION BLOCK ---
if __name__ == "__main__":
    RECIPES_FILE = "recipes.json"
    CHARACTERS_FILE = "characters.json"
    MISSING_COMPONENTS_FILE = "missing_components.json"
    UNUSED_CHARACTERS_FILE = "unused_characters.json"

    deduplicate_file(CHARACTERS_FILE)
    print()
    deduplicate_file(RECIPES_FILE)
    print()

    verify_and_save_missing_components(RECIPES_FILE, CHARACTERS_FILE, MISSING_COMPONENTS_FILE)
    print()

    find_unused_characters(RECIPES_FILE, CHARACTERS_FILE, UNUSED_CHARACTERS_FILE)

    print("\n" + "="*40)
    print("Tüm işlemler tamamlandı.")
    print("="*40)