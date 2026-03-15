// Stub — original service was removed during cleanup.
// UnifiedQuantumSystem.tsx still references these exports.

interface AIResponse {
  response: string;
  confidence: number;
  quantumScore: string;
  tokensUsed: number;
}

const defaultResponse: AIResponse = {
  response: 'خدمة AI غير متوفرة حالياً. يرجى استخدام لوحة التحكم الرئيسية.',
  confidence: 0,
  quantumScore: '0',
  tokensUsed: 0,
};

export const aiService = {
  sendMessage: async (_message: string, _personality?: string): Promise<AIResponse> =>
    defaultResponse,
  clearHistory: (): void => { /* no-op */ },
};
