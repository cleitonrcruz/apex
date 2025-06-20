// Função para verificar se os campos de login e senha estão preenchidos
function checkInputs() {
    // Atribui a variável user o conteúdo do item :P9999_USERNAME
    var user = $('#P9999_USERNAME').val();
    // Atribui a variável pass o conteúdo do item :P9999_PASSWORD
    var pass = $('#P9999_PASSWORD').val();
    if(user && pass) {
        // #B26242096300373912 é o ID do botão de login.
        $('#B26242096300373912').prop('disabled', false); 
    } else {
        $('#B26242096300373912').prop('disabled', true);
    }
}

// Adiciona o evento aos campos de entrada
$('#P9999_USERNAME, #P9999_PASSWORD').on('input', checkInputs);

// Chamada inicial para o estado atual dos campos
checkInputs();