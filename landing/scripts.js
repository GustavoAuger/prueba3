// Contador que se incrementa cuando se hace clic en el botón "Comenzar"
let counter = 0;
const btnSecondary = document.querySelector('.btn-secondary');
const counterDisplay = document.createElement('div');
counterDisplay.style.textAlign = 'center';
counterDisplay.style.marginTop = '20px';
counterDisplay.style.fontSize = '1.5rem';
document.querySelector('footer').appendChild(counterDisplay);

btnSecondary.addEventListener('click', () => {
  counter++;
  counterDisplay.textContent = `¡Has hecho clic ${counter} veces!`;
});
