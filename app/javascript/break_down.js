window.addEventListener('load', () => {
  const totalPrice = document.getElementById("item-price");
  totalPrice.addEventListener("input", () => {
    const priceValue = totalPrice.value;
    const commission = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    commission.innerHTML = Math.floor(priceValue * 0.1);
    profit.innerHTML = Math.ceil(priceValue * 0.9);
  });
});