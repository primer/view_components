import resolve from "@rollup/plugin-node-resolve"
import typescript from "@rollup/plugin-typescript"
import { terser } from "rollup-plugin-terser"
import pkg from "./package.json"

export default {
  input: pkg.module,
  output: {
    file: pkg.main,
    format: "es",
    sourcemap: true
  },
  plugins: [
    resolve(),
    typescript(),
    terser({keep_classnames: /Element$/})
  ],
  onwarn: (warning, warn) => {
    if (warning.code === "THIS_IS_UNDEFINED") return
    warn(warning)
  }
}
