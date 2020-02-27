document.addEventListener("DOMContentLoaded", (event) => {
    const valid_value = (value) => {
        return(value > 0 && value < 100)
    };

    const buttons = document.querySelectorAll('input[type=submit]');
    const inputs = document.querySelectorAll('input[type=text]');

    inputs.forEach((elem) =>
        elem.onchange = ((event) =>
            buttons.forEach((button) => {
                button.disabled = !valid_value(event.target.value)
            })
        )
    );
});
