import github from 'eslint-plugin-github'
import tseslint from 'typescript-eslint'
import {defineConfig, globalIgnores} from 'eslint/config'

const config = defineConfig([
  globalIgnores(['**/*.d.ts']),
  github.getFlatConfigs().browser,
  github.getFlatConfigs().recommended,
  github.getFlatConfigs().react,
  ...github.getFlatConfigs().typescript,
  {
    files: ['**/*.{js,mjs,cjs,jsx,mjsx,ts,tsx,mtsx}'],
    ignores: ['eslint.config.mjs', '**/*.d.ts'],
    rules: {
      'github/array-foreach': 'error',
      'github/async-preventdefault': 'warn',
      'github/no-then': 'error',
      'github/no-blur': 'error',
      'github/filenames-match-regex': 'off',
      'custom-elements/no-exports-with-element': 'off',
      'custom-elements/expose-class-on-global': 'off',
      'eslint-comments/no-use': 0,
      'filenames/match-regex': 0,
      'import/no-namespace': 0,
      'no-shadow': 0,
      'no-unused-vars': 'off',
      '@typescript-eslint/no-unused-vars': [
        'error',
        {
          ignoreRestSiblings: true,
        },
      ],
      'i18n-text/no-en': 'off',
      'no-restricted-syntax': [
        'error',
        {
          message:
            'stopPropagation() and friends are considered dangerous because they swallow events that consumers may listen for. Consider alternatives.',
          selector: "CallExpression[callee.property.name='stopPropagation']",
        },
        {
          message:
            'stopImmediatePropagation() and friends are considered dangerous because they swallow events that consumers may listen for. Consider alternatives.',
          selector: "CallExpression[callee.property.name='stopImmediatePropagation']",
        },
      ],
    },
  },
])

export default tseslint.config(config)
