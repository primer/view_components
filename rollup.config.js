import resolve from "@rollup/plugin-node-resolve"
import typescript from "@rollup/plugin-typescript"
import { terser } from "rollup-plugin-terser"
import pkg from "./package.json"

const onwarn = (warning, warn) => {
  if (warning.code === "THIS_IS_UNDEFINED") return
  warn(warning)
}

const terserOptions = terser({keep_classnames: /Element$/}) // comment out terser in dev if you want debugger statements

export default [
  {
    input: pkg.module,
    output: {
      file: pkg.main,
      format: "iife",
      sourcemap: true
    },
    plugins: [
      resolve(),
      typescript(),
      terserOptions
    ],
    onwarn
  },
  {
    // lazy.js is compiled from lazy.ts by `npx tsc` (which always runs before `npx rollup -c`)
    input: "app/components/primer/lazy.js",
    output: {
      dir: "app/assets/javascripts/primer_view_components_lazy",
      format: "es",
      sourcemap: true
    },
    preserveEntrySignatures: false,
    plugins: [
      resolve(),
      terserOptions
    ],
    onwarn
  }
]
