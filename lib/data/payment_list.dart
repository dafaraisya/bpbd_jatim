enum PaymentList { linkAja, ovo, gopay, mandiri, bca, bri }

getAsset(PaymentList paymentMethod) {
  if (paymentMethod == PaymentList.linkAja) {
    return 'linkaja.png';
  } else if (paymentMethod == PaymentList.ovo) {
    return 'ovo.png';
  } else if (paymentMethod == PaymentList.gopay) {
    return 'gopay.png';
  } else if (paymentMethod == PaymentList.mandiri) {
    return 'mandiri.png';
  } else if (paymentMethod == PaymentList.bca) {
    return 'bca.png';
  } else if (paymentMethod == PaymentList.bri) {
    return 'bri.png';
  }
}
