# Lint Me

> A script to install Upstatement linting configs ([ESLint](https://www.npmjs.com/package/@upstatement/eslint-config) & [Prettier](https://www.npmjs.com/package/@upstatement/prettier-config)) to your project

## Installation

1. Clone this repo

2. In your terminal config (i.e. `.zshrc`, `.bash_rc`, etc.) add an alias for running the install script

   ```sh
   alias lintme="sh ~/<insert-path-to-this-repo>/install.sh"
   ```

3. Now you should be able to run `lintme` at the root of any project to automatically install Upstatement's ESLint & Prettier linting configs

## Usage

At the root of any project, simply run

```sh
lintme <type>
```

### Default

```sh
lintme
```

### Four Spaces

```sh
lintme four
```

### React

```sh
lintme react
```

### Vue

```sh
lintme vue
```

You should end up with the following files at the root of your project

- `.editorconfig`
- `.eslintrc`
- `.gitignore`
- `package-lock.json`
- `package.json`
- `prettier.config.js`
