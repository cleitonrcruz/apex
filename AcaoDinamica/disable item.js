var status = apex.item('P29_LEAD_STATUS_ID').getValue();

if (status.length == 1 && status[0] == '5'){
    apex.item('P29_LEAD_STATUS_UNQUALIFIED_ID').enable();
} else {
    apex.item('P29_LEAD_STATUS_UNQUALIFIED_ID').setValue(null);
    apex.item('P29_LEAD_STATUS_UNQUALIFIED_ID').disable();
}