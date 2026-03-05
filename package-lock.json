module.exports = {
    testEnvironment: 'node',
    testPathIgnorePatterns: ['/node_modules/', '/dist/'],
    testMatch: [
        '**/__tests__/**/*.+(js|ts)',
        '**/?(*.)+(spec|test).+(js|ts)',
    ],
    setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
    collectCoverage: true,
    coverageDirectory: '<rootDir>/coverage/',
    coverageReporters: ['text', 'lcov'],
    // Unit test setup
    globals: {
        MY_GLOBAL: true,
    },
    // Integration test setup
    setupFiles: ['<rootDir>/setup.integration.js'],
};