var transactions = ':';
if (this.data.selectedRecords[0]){
    for ( i = 0; i < this.data.selectedRecords.length; i++ ) {
        transactions = transactions + this.data.model.getValue(this.data.selectedRecords[i], "ID") + ':';        
    }
    apex.item("P195_CASE_INSTALLMENT").setValue(transactions);
} else {
    apex.item("P195_CASE_INSTALLMENT").setValue(null);
}