import { tool } from '@openrouter/sdk';
import { z } from 'zod';

export const timeTool = tool({
    name: 'get_current_time',
    description: 'Get the current date and time',
    inputSchema: z.object({
        timezone: z.string().optional().describe('Timezone (e.g., "UTC", "America/New_York")'),
    }),
    execute: async ({ timezone }) => {
        return {
            time: new Date().toLocaleString('en-US', { timeZone: timezone || 'UTC' }),
            timezone: timezone || 'UTC',
        };
    },
});

export const calculatorTool = tool({
    name: 'calculate',
    description: 'Perform mathematical calculations',
    inputSchema: z.object({
        expression: z.string().describe('Math expression (e.g., "2 + 2", "sqrt(16)")'),
    }),
    execute: async ({ expression }) => {
        // Simple safe eval for basic math
        const sanitized = expression.replace(/[^0-9+\\-*/().\\s]/g, '');
        const result = Function(`"use strict"; return (${sanitized})`)();
        return { expression, result };
    },
});

// Mock web search tool (since specific API not provided, but requested for "background research")
// In a real scenario, this would call Google Search API, Bing XML, or similar.
export const webSearchTool = tool({
    name: 'web_search',
    description: 'Search the web for information.',
    inputSchema: z.object({
        query: z.string().describe('The search query'),
    }),
    execute: async ({ query }) => {
        console.log(`[WebSearch] Mocking search for: ${query}`);
        // Return a mock response or use a free search API if available/configured.
        // For now, we simulate a finding.
        return {
            query,
            results: [
                { title: `Result for ${query}`, snippet: `This is a simulated search result for ${query}.` },
                { title: "More info", snippet: "Additional details found on the web." }
            ]
        };
    },
});

export const defaultTools = [timeTool, calculatorTool, webSearchTool];
