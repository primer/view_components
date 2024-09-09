import { PrimerAlphaActionList } from './action-list';
import { render } from './render';
const result = render(new PrimerAlphaActionList({}), (component) => {
    component.with_heading({ title: 'Heading' });
    component.with_item({ label: 'Label' }, (item) => {
        item.with_description({}, () => 'Description');
    });
});
console.log(JSON.stringify(result.serialize()));
