// This is a Vercel Serverless Function that acts as a proxy.

export default async function handler(request, response) {
  // 1. Get the text to speak from the URL query (e.g., /api/tts?text=你好)
  const { text } = request.query;

  if (!text) {
    return response.status(400).send('Bad Request: Missing text parameter');
  }

  // 2. Construct the real Google Translate TTS URL
  const encodedText = encodeURIComponent(text);
  const ttsUrl = `https://translate.google.com/translate_tts?ie=UTF-8&q=${encodedText}&tl=zh-CN&client=tw-ob`;

  try {
    // 3. Fetch the audio from Google on the server-side (no CORS issue here)
    const googleResponse = await fetch(ttsUrl, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',
      },
    });

    if (!googleResponse.ok) {
      throw new Error(`Google TTS request failed with status ${googleResponse.status}`);
    }

    // 4. Stream the audio back to the browser with the correct headers
    const audioBuffer = await googleResponse.arrayBuffer();

    response.setHeader('Content-Type', 'audio/mpeg');
    response.setHeader('Cache-Control', 'public, max-age=31536000, immutable');
    response.status(200).send(Buffer.from(audioBuffer));

  } catch (error) {
    console.error('TTS Proxy Error:', error);
    return response.status(500).send('Internal Server Error');
  }
}