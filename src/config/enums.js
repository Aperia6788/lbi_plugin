// ==================== ENUMS ====================
export const LLM_ROLE = {
    SYSTEM: "system",
    USER: "user",
    ASSISTANT: "assistant",
};

export const LLM_PROVIDER = {
    GOOGLEAI: "GoogleAI",
    VERTEXAI: "VertexAI",
    ANTHROPIC: "Anthropic",
    DEEPSEEK: "Deepseek",
    OPENAI: "OpenAI",
    AWS: "AWS",
    OPENAICOMPATIBLE: "OpenAICompatible",
    OPENAICOMPATIBLE2: "OpenAICompatible2",
    OPENAICOMPATIBLE3: "OpenAICompatible3",
    OPENAICOMPATIBLE4: "OpenAICompatible4",
    OPENAICOMPATIBLE5: "OpenAICompatible5",
    OPENAICOMPATIBLE6: "OpenAICompatible6",
    OPENAICOMPATIBLE7: "OpenAICompatible7",
    OPENAICOMPATIBLE8: "OpenAICompatible8",
    OPENAICOMPATIBLE9: "OpenAICompatible9",
    NOVELAI: "NovelAI",
};

export const LLM_TOKENIZER = {
    O200K_BASE: "o200k_base",
    CL100K_BASE: "cl100k_base",
    MISTRAL: "mistral",
    LLAMA: "llama",
    NOVELAI: "novelai",
    CLAUDE: "claude",
    NOVELLIST: "novellist",
    LLAMA3: "llama",
    GEMMA: "gemma",
    COHERE: "cohere",
};

export const LLM_FLAG = {
    hasFullSystemPrompt: "hasFullSystemPrompt",
    isThinkingModel: "isThinkingModel",
    isExperimentalModel: "isExperimentalModel",
    isFreeModel: "isFreeModel",
    hasGroundingSearch: "hasGroundingSearch",
    hasThinkingTokens: "hasThinkingTokens",
    hasMaxCompletionTokens: "hasMaxCompletionTokens",
    forceDisableSamplingParams: "forceDisableSamplingParams",
};

export const REQUEST_TYPE = {
    CHAT: "chat",
    EMOTION: "emotion",
    MEMORY: "memory",
    TRANSLATION: "translation",
    OTHER: "other",
    POLISH: "polish",
    CHECKLIST: "checklist",
    UNKNOWN: "unknown",
};

export const LOGLEVEL = {
    DEBUG: 0,
    INFO: 1,
    WARN: 2,
    ERROR: 3,
};

// Gemini specific enums
export const GEMINI_ROLE = {
    USER: "user",
    MODEL: "model",
};

export const GEMINI_SAFETY_THRESHOLD = {
    OFF: "OFF",
    BLOCK_NONE: "BLOCK_NONE",
};
