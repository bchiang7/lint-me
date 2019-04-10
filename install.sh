#!/bin/bash

function npmInit {
  if [ -e ./package.json ]; then
    echo 'package.json already exists'
  else
    echo '{
  "name": "@upstatement/project-name",
  "version": "0.0.0",
  "description": "",
  "keywords": [],
  "author": "",
  "license": "",
  "main": "",
  "scripts": {},
  "dependencies": {},
  "devDependencies": {}
}' > package.json
  fi
}

function addHooks {
  read -p "Do you want to use pre-commit hooks? (y/n) " choice
  case "$choice" in
    y|Y )
      echo "Installing husky, pretty-quick, and lint-staged packages..."

      eval "npm install -D husky pretty-quick lint-staged"

      INSERT_HERE=$(( $(wc -l < package.json) - 1 ))

      # add pre-commit hook configs to package.json
      eval "head -n $INSERT_HERE package.json > temp.txt"

      eval "sed '$INSERT_HERE s/$/,/' temp.txt > temp2.txt"

      echo '  "husky": {
    "hooks": {
      "pre-commit": "pretty-quick --staged && lint-staged"
    }
  },
  "lint-staged": {
    "*.js": [
      "eslint --fix",
      "git add"
    ]
  }
}' >> temp2.txt

      eval "mv temp2.txt package.json && rm temp.txt"
      ;;
    n|N )
      echo ''
      ;;
    * )
  esac
}

SPACING=2

function scaffold {
  # create files
  eval "touch .editorconfig prettier.config.js .eslintrc"

  # init package.json
  npmInit

  if [ -z "$1" ]; then
    eval "npm install -D @upstatement/eslint-config @upstatement/prettier-config eslint babel-eslint prettier eslint-config-prettier"

    echo '{
  "extends": "@upstatement",
  "parserOptions": {
    "sourceType": "module"
  },
  "env": {
    "browser": true,
    "node": true
  }
}' > .eslintrc

  elif [ $1 = four ]; then

    eval "npm install -D @upstatement/eslint-config @upstatement/prettier-config eslint babel-eslint prettier eslint-config-prettier"

    echo '{
  "extends": "@upstatement/eslint-config/four-spaces",
  "parserOptions": {
    "sourceType": "module"
  },
  "env": {
    "browser": true,
    "node": true
  }
}' > .eslintrc

    SPACING=4

  elif [ $1 = react ]; then

    eval "npm install -D @upstatement/eslint-config @upstatement/prettier-config eslint babel-eslint prettier eslint-config-prettier eslint-plugin-react eslint-plugin-jsx-a11y"

    echo '{
  "extends": "@upstatement/eslint-config/react"
}' > .eslintrc

  elif [ $1 = vue ]; then

    eval "npm install -D @upstatement/eslint-config @upstatement/prettier-config eslint babel-eslint prettier eslint-config-prettier  eslint-plugin-vue vue-eslint-parser"

    echo '{
  "extends": "@upstatement/eslint-config/vue"
}' > .eslintrc

  else
    echo 'Uh oh something went wrong'
  fi

  echo "root = true

[*]
charset = utf-8
indent_style = space
indent_size = $SPACING
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true" > .editorconfig

  if [ $SPACING = 4 ]; then
    echo "module.exports = require('@upstatement/prettier-config/four-spaces');" > prettier.config.js
  else
    echo "module.exports = require('@upstatement/prettier-config');" > prettier.config.js
  fi

  addHooks
}

# Default config
if [ -z "$1" ]; then
  echo 'Setting up default linting configs...'
  scaffold

# Four spaces config
elif [ $1 = four ]; then
  echo "Setting up four spaces linting config..."
  scaffold four

# React config
elif [ $1 = react ]; then
  echo "Setting up react linting config..."
  scaffold react

# Vue Config
elif [ $1 = vue ]; then
  echo "Setting up vue linting config..."
  scaffold vue

else
  echo 'Please specify a valid config, such as `react` or `vue`'
fi
