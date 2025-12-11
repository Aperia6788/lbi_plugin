export default {
    input: 'src/index.js',
    output: {
        file: 'dist/LBI-0.35.0-pre26_Refactored.js',
        format: 'es',  // ES module format to preserve top-level code
        sourcemap: false,
    },
    treeshake: false,  // Keep all code to preserve plugin functionality
};
