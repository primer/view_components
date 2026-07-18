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
    input: "app/components/primer/lazy.js",
    output: {
      dir: "app/assets/javascripts/primer_view_components_lazy",
      format: "es",
      sourcemap: true,
      preserveModules: false
    },
    preserveEntrySignatures: false,
    plugins: [
      resolve(),
      terserOptions
    ],
    onwarn
  }
]
