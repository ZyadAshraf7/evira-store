class QAItem {
  String question;
  String answer;

  QAItem({required this.question, required this.answer});
}

List<QAItem> FAQs = [
  QAItem(
      question: "What is Evira?",
      answer:
          "Evira is a cutting-edge ecommerce platform designed to provide you with a seamless and convenient online shopping experience. Our platform hosts a wide range of products from various categories, allowing you to explore and purchase items from the comfort of your own home. With secure payment options, user-friendly navigation, and a commitment to customer satisfaction, Evira aims to redefine the way you shop online."),
  QAItem(
      question: "How to use Evira?",
      answer:
          """Using Evira is easy and straightforward. Follow these steps to make the most of our platform:
          1- Browse: Explore our diverse collection of products by navigating through different categories or using the search bar.
          2- Select: Click on a product to view its details, images, and specifications.
          3- Add to Cart: Found something you like? Add it to your cart by clicking the "Add to Cart" button.
          4- Checkout: Once you're done shopping, click on the cart icon at the top and proceed to checkout. Enter your shipping and payment details.
          5- Payment: Choose a secure payment method and confirm your order.
          6- Track: After your order is confirmed, you can track its status through your Evira account.
          7- Delivery: Sit back and relax as your order gets delivered to your doorstep."""),
  QAItem(
      question: "How do I cancel a orders product?",
      answer:
          """If you need to cancel a product from your order, follow these steps:
      Log In: Sign in to your Evira account.
      Order Details: Go to your order details and locate the specific order containing the product you want to cancel.
      Cancel Item: Click on the order and find the product you want to cancel. Select the "Cancel" option next to the item.
      Confirmation: Confirm your cancellation. Your order will be updated accordingly."""),
  QAItem(
      question: "Is Evira free to use?",
      answer:
          """Yes, Evira is free to use as a shopping platform. You can explore products, add items to your cart, and browse various categories without any charges. However, keep in mind that the prices of the products you choose to purchase will apply."""),
  QAItem(
      question: "How to add promo on Evira?",
      answer:
          """To add a promotional code or discount on Evira, follow these steps:
      Cart: Add your desired items to the cart.
      Promo Code: Beneath the cart summary, you'll find a field labeled "Promo Code" or "Discount Code."
      Enter Code: Enter the promo code you have in the designated field.
      Apply: Click the "Apply" button next to the field. The discount associated with the code will be applied to your order.
      Checkout: Continue with the checkout process, and your discounted total will be reflected.""")
];
