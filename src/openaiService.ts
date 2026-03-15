// Stub — original service was removed during cleanup.
// UnifiedQuantumSystem.tsx still references this export.

export class OpenAIService {
  async createResponse(
    _promptId: string,
    _vars: Record<string, string>,
    _version?: string
  ): Promise<{ text: string }> {
    return { text: 'خدمة OpenAI غير متوفرة. استخدم لوحة التحكم الرئيسية.' };
  }
}
