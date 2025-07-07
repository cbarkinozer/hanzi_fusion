import json
import os

# --- CONFIGURATION ---
INPUT_CHAR_FILE = "characters.json"
OUTPUT_RECIPES_FILE = "recipes.json"
OUTPUT_SINGLES_FILE = "single_characters.json"
# ---------------------

def create_recipe(inputs, output):
    """Helper function to create a recipe dictionary."""
    return {"inputs": inputs, "output": output}

def generate_recipes():
    """
    Reads characters from a JSON file and generates recipes based on character length.
    """
    if not os.path.exists(INPUT_CHAR_FILE):
        print(f"Hata: '{INPUT_CHAR_FILE}' dosyası bulunamadı. Lütfen dosyanın script ile aynı dizinde olduğundan emin olun.")
        return

    try:
        with open(INPUT_CHAR_FILE, 'r', encoding='utf-8') as f:
            characters_data = json.load(f)
    except json.JSONDecodeError:
        print(f"Hata: '{INPUT_CHAR_FILE}' dosyası geçerli bir JSON formatında değil.")
        return

    all_recipes = []
    single_characters = []
    processed_outputs = set()

    print(f"{len(characters_data)} adet karakter/kelime işleniyor...")

    for entry in characters_data:
        char_word = entry.get("char")
        if not char_word:
            continue
        if char_word in processed_outputs:
            continue

        length = len(char_word)

        if length == 1:
            single_characters.append(char_word)
        elif length == 2:
            all_recipes.append(create_recipe([char_word[0], char_word[1]], char_word))
            processed_outputs.add(char_word)
        elif length == 3:
            all_recipes.append(create_recipe([char_word[0:2], char_word[2]], char_word))
            all_recipes.append(create_recipe([char_word[0], char_word[1:3]], char_word))
            processed_outputs.add(char_word)
        elif length == 4:
            all_recipes.append(create_recipe([char_word[0:2], char_word[2:4]], char_word))
            processed_outputs.add(char_word)
        elif length == 8:
            all_recipes.append(create_recipe([char_word[0:4], char_word[4:8]], char_word))
            processed_outputs.add(char_word)
        else:
            if length > 1:
                print(f"Uyarı: '{char_word}' kelimesi {length} karakterli olduğu için atlanıyor (kural tanımlanmamış).")

    try:
        # --- GÜNCELLENEN YAZMA KISMI ---
        # recipes.json dosyasını istenen "her nesne bir satırda" formatında yaz
        with open(OUTPUT_RECIPES_FILE, 'w', encoding='utf-8') as f:
            if not all_recipes:
                f.write("[]") # Tarif listesi boşsa boş bir liste yaz
            else:
                f.write("[\n")
                # Her bir tarifi tek satırlık bir JSON string'ine çevir
                recipe_lines = [json.dumps(recipe, ensure_ascii=False) for recipe in all_recipes]
                # Tüm satırları aralarına ",\n" koyarak birleştir ve dosyaya yaz
                f.write(",\n".join(recipe_lines))
                f.write("\n]")

        # single_characters.json dosyasını standart formatta yaz (bu dosya için format değiştirilmedi)
        with open(OUTPUT_SINGLES_FILE, 'w', encoding='utf-8') as f:
            json.dump(single_characters, f, ensure_ascii=False, indent=2)

        print("\n--- İşlem Tamamlandı! ---")
        print(f"✅ Toplam {len(all_recipes)} tarif oluşturuldu ve '{OUTPUT_RECIPES_FILE}' dosyasına istenen formatta kaydedildi.")
        print(f"✅ Toplam {len(single_characters)} tek karakter bulundu ve '{OUTPUT_SINGLES_FILE}' dosyasına kaydedildi.")

    except PermissionError:
        print("\n--- HATA: YAZMA İZNİ SORUNU ---")
        print(f"'{OUTPUT_RECIPES_FILE}' veya '{OUTPUT_SINGLES_FILE}' dosyasına yazma izni alınamadı (PermissionError).")
        print("Lütfen dosyaların başka bir programda açık olmadığından ve klasörde yazma izniniz olduğundan emin olun.")
    except Exception as e:
        print(f"\nBeklenmedik bir hata oluştu: {e}")


if __name__ == "__main__":
    generate_recipes()