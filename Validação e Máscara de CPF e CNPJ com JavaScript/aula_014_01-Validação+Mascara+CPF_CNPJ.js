
/*
    Máscara de CPF, CNPJ, CEP e telefone.
    Máscara em tempo de execução.
    Inserir código no campo "Cabeçalho HTML"
*/
<script type="text/javascript">

function mascara(o,f){
    v_obj=o
    v_fun=f
    setTimeout("execmascara()",1)
}
function execmascara(){
    v_obj.value=v_fun(v_obj.value)
}
function mtel(v){
    v=v.replace(/\D/g,"");
    v=v.replace(/^(\d{2})(\d)/g,"($1) $2");
    v=v.replace(/(\d)(\d{4})$/,"$1-$2");
    return v;
}
function cpfcnpj(v){
    if (v.length <= 14) {
        v=v.replace(/\D/g,"")
        v=v.replace(/(\d{3})(\d)/,"$1.$2")
        v=v.replace(/(\d{3})(\d)/,"$1.$2")
        v=v.replace(/(\d{3})(\d{1,2})$/,"$1-$2")
   } else {
        v=v.replace(/\D/g,"")
        v=v.replace(/^(\d{2})(\d)/,"$1.$2")
        v=v.replace(/^(\d{2})\.(\d{3})(\d)/,"$1.$2.$3")
        v=v.replace(/\.(\d{3})(\d)/,".$1/$2")
        v=v.replace(/(\d{4})(\d)/,"$1-$2")
    }
    return v;
}
function cep(v){
    v=v.replace(/\D/g,"")
    v=v.replace(/^(\d{5})(\d)/,"$1-$2")
    return v
}
function id( el ){
    return document.getElementById( el );
}
window.onload = function(){
    id('P20_DOCUMENTO').onkeypress = function(){ //P20_DOCUMENTO é o nome do Region Body criado para ser digitado o CPF ou CNPJ
        mascara( this, cpfcnpj );
    }
}

</script>