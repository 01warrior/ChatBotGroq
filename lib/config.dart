abstract class AppConfig {
  static const apiKey =
      'Mettez votre clé API ici';
  static const apiUrl = 'https://api.groq.com/openai/v1/chat/completions';

  static const defaultModel = 'openai/gpt-oss-20b';
  static const maxTokens = 8192;

  static const List<String> availableModels = [
    'qwen/qwen3-32b',
    'deepseek-r1-distill-llama-70b',
    'gemma2-9b-it',
    'llama-3.1-8b-instant',
    'openai/gpt-oss-120b',
    'moonshotai/kimi-k2-instruct',
    'openai/gpt-oss-20b',
    "llama-3.3-70b-versatile",
    "openai/gpt-oss-20b",
    "meta-llama/llama-prompt-guard-2-86m",
    "meta-llama/llama-prompt-guard-2-22m",
    "meta-llama/llama-4-scout-17b-16e-instruct"
  ];

  static const List<String> reasoningModels = [
    'openai/gpt-oss-20b',
    // Add others if they support
  ];
}
