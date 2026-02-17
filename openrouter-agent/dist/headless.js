import { createAgent } from './agent.js';
import { defaultTools } from './tools.js';
async function main() {
    const apiKey = process.env.OPENROUTER_API_KEY;
    if (!apiKey) {
        console.error('Error: OPENROUTER_API_KEY environment variable is required.');
        process.exit(1);
    }
    // User requested "minimax/minimax-m2.5" as main agent
    const agent = createAgent({
        apiKey,
        model: 'minimax/minimax-m2.5',
        instructions: 'You are a helpful coding assistant. You can use tools to help the user.',
        tools: defaultTools,
    });
    // Hook into events
    agent.on('thinking:start', () => console.log('\n🤔 Thinking...'));
    agent.on('tool:call', (name, args) => console.log(`🔧 Using ${name}:`, args));
    // agent.on('stream:delta', (delta) => process.stdout.write(delta));
    agent.on('stream:delta', (delta) => {
        // Basic stdout write
        process.stdout.write(delta);
    });
    agent.on('stream:end', () => console.log('\n'));
    agent.on('error', (err) => console.error('❌ Error:', err.message));
    // Interactive loop
    const readline = await import('readline');
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    console.log('OpenRouter Agent (Minimax M2.5) ready. Type your message (Ctrl+C to exit):\n');
    const prompt = () => {
        rl.question('You: ', async (input) => {
            if (!input.trim()) {
                prompt();
                return;
            }
            try {
                await agent.send(input);
            }
            catch (e) {
                console.error(e);
            }
            prompt();
        });
    };
    prompt();
}
main().catch(console.error);
