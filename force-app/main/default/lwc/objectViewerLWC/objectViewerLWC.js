import { LightningElement, wire, track } from 'lwc';
import getCustObjList from '@salesforce/apex/DisplayObjectDetail.customObjDetail';
import getStandObjList from '@salesforce/apex/DisplayObjectDetail.standardObjDetail';

export default class ObjectViewerLWC extends LightningElement {

	@track columns = [{
		label: 'Name',
		fieldName: 'label',
		type: 'text',
		initialWidth: 200,
		wrapText: true
	},
	{
		label: 'API Name',
		fieldName: 'apiName',
		type: 'text',
		initialWidth: 200,
	},
	{
		label: 'Record Type',
		fieldName: 'recordTypes',
		type: 'text',
		initialWidth: 150,
	},
	{
		label: 'Child Relationship Name',
		fieldName: 'childRelationShips',
		type: 'text',
		initialWidth: 5000,
	}
	];
	@track darkChecked = false;
	value = 'Standard';
	spinnerShow = true;
	isStandardSelected = true;
	selectedVal
	@track custObjLs;
	@track standObjLs;

	get options() {
		return [
			{ label: 'Standard', value: 'Standard' },
			{ label: 'Custom', value: 'Custom' }
		];

	}

	@wire(getCustObjList)
	wiredCustomObjs({
		error,
		data
	}) {
		if (data) {
			this.spinnerShow = false;
			this.custObjLs = data;
		}
	}
	@wire(getStandObjList)
	wiredStandardObjs({
		error,	data}) {
		if (data) {
			this.spinnerShow = false;
			console.log('STD ' + JSON.stringify(data));
			this.standObjLs = data;
		}
	}

	handleRadioChange(event) {
		this.spinnerShow = true;
		const selectedOption = event.detail.value;
		this.selectedVal = selectedOption;
		if (this.selectedVal == 'Standard') {
			this.isStandardSelected = true;
			this.spinnerShow = false;
		} else if (this.selectedVal == 'Custom') {
			this.spinnerShow = false;
			this.isStandardSelected = false;
		}
	}
}