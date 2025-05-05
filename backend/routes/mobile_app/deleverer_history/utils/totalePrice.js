
/**
 * @param {number} grams 
 * @returns {number} 
 */
const gramsToKg = (grams) => {
    return grams / 1000;
};

/**
 * @param {Object} product
 * @returns {number}
 */
const calculateProductTotalPrice = (product) => {
    if (product.unitProd === 0) {

        return product.unitPriceProdCart * product.qttyProdCart;
    } else {
        return product.unitPriceProdCart * gramsToKg(product.qttyProdCart);
    }
};

module.exports = {
    calculateProductTotalPrice,
    gramsToKg
};