import { serializeString, serializeSysArgs } from './types';
class Slot {
    constructor(args, content) {
        this.args = args;
        this.content = content;
    }
    serialize() {
        return {
            args: serializeSysArgs(this.args),
            content: serializeString(this.content),
        };
    }
}
export class ViewComponent {
    constructor(args) {
        this.args = args;
        this.singleSlots = new Map();
        this.manySlots = new Map();
    }
    serialize() {
        const slots = new Map();
        this.serializeSingleSlotsInto(slots);
        this.serializeManySlotsInto(slots);
        return {
            args: serializeSysArgs(this.args),
            slots: Object.fromEntries(slots),
        };
    }
    serializeSingleSlotsInto(map) {
        for (const [name, slot] of this.singleSlots) {
            map.set(name, [slot.serialize()]);
        }
    }
    serializeManySlotsInto(map) {
        for (const [name, slots] of this.manySlots) {
            const serializedMany = [];
            for (const slot of slots) {
                serializedMany.push(slot.serialize());
            }
            map.set(name, serializedMany);
        }
    }
}
export class PrimerAlphaActionList extends ViewComponent {
    with_heading({ title, heading_level, subtitle, scheme, ...system_arguments }, callback) {
        const args = { title, heading_level, subtitle, scheme, ...system_arguments };
        const instance = new PrimerAlphaActionListHeading(args);
        this.singleSlots.set('heading', new Slot(args, (callback ? callback(instance) : undefined) || ''));
    }
    with_item({ label, ...system_arguments }, callback) {
        if (!this.manySlots.has('items')) {
            this.manySlots.set('items', []);
        }
        const args = { label, ...system_arguments };
        const instance = new PrimerAlphaActionListItem(args);
        this.manySlots.get('items').push(new Slot(args, (callback ? callback(instance) : undefined) || ''));
    }
}
export class PrimerAlphaActionListHeading extends ViewComponent {
}
export class PrimerAlphaActionListItem extends ViewComponent {
    with_description(args, callback) {
        this.singleSlots.set('description', new Slot(args, callback() || ''));
    }
}
