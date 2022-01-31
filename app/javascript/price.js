function price (){
  const inputPrice = document.getElementById("item-price");
  const feePrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  const fee = 0.1

  inputPrice.addEventListener('input', () => {
  const inputValue = inputPrice.value;
  feePrice.innerHTML = Math.floor(inputValue * fee);
  profit.innerHTML = Math.floor(inputValue - inputValue * fee);
  });
};

window.addEventListener('load', price);
