export class Sym {
    constructor(value) {
        this.value = value;
    }
    serialize() {
        return {
            type: 'symbol',
            value: this.value,
        };
    }
}
export const serializeString = (str) => {
    return { type: 'string', value: str };
};
export const serializeNumber = (num) => {
    return { type: 'number', value: num };
};
export const serializeBoolean = (bool) => {
    return { type: 'boolean', value: bool };
};
export const serializeSysArgs = (args) => {
    const results = [];
    if (args) {
        for (const k in args) {
            const v = args[k];
            if (typeof v === 'string') {
                results.push({ key: k, value: serializeString(v) });
            }
            else if (typeof v === 'number') {
                results.push({ key: k, value: serializeNumber(v) });
            }
            else if (v === true || v === false) {
                results.push({ key: k, value: serializeBoolean(v) });
            }
            else if (v instanceof Sym) {
                results.push({ key: k, value: v.serialize() });
            }
            else if (v === null || v === undefined) {
                results.push({ key: k, value: { type: 'nil', value: v } });
            }
        }
    }
    return { type: 'hash', value: results };
};
