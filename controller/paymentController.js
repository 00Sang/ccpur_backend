const Payment = require("../models/paymentModel");

// Create a new payment
exports.createPayment = async (req, res) => {
  try {
    const { student_id, application_id, amount, payment_method, transaction_id } = req.body;

    const payment = await Payment.create({
      student_id,
      application_id,
      amount,
      payment_method,
      transaction_id,
    });

    res.status(201).json(payment);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get payment details by ID
exports.getPaymentById = async (req, res) => {
  try {
    const payment = await Payment.findByPk(req.params.id);
    if (!payment) return res.status(404).json({ message: "Payment not found" });

    res.json(payment);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// List all payments with filters
exports.getAllPayments = async (req, res) => {
  try {
    const { student_id, application_id, status } = req.query;
    const filter = {};
    if (student_id) filter.student_id = student_id;
    if (application_id) filter.application_id = application_id;
    if (status) filter.payment_status = status;

    const payments = await Payment.findAll({ where: filter });
    res.json(payments);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.updatePaymentStatus = async (req, res) => {
    try {
      const payment = await Payment.findByPk(req.params.id);
      if (!payment) return res.status(404).json({ message: "Payment not found" });
  
      // If a transaction_id is provided, automatically mark the status as "Paid"
      if (req.body.transaction_id) {
        payment.transaction_id = req.body.transaction_id;
        payment.payment_status = "Paid";
      } else {
        // Otherwise, update status if provided in the request
        payment.payment_status = req.body.payment_status || payment.payment_status;
      }
  
      await payment.save();
      res.json(payment);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  };
  

// Delete a payment
exports.deletePayment = async (req, res) => {
  try {
    const payment = await Payment.findByPk(req.params.id);
    if (!payment) return res.status(404).json({ message: "Payment not found" });

    await payment.destroy();
    res.json({ message: "Payment deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Create a payment intent for online payments (e.g., Stripe)
exports.createPaymentIntent = async (req, res) => {
  try {
    const { amount, currency = "INR" } = req.body;

    // Example: Integrate with Stripe
    const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);
    const paymentIntent = await stripe.paymentIntents.create({
      amount: amount * 100, // Convert to smallest currency unit
      currency,
      payment_method_types: ["card"],
    });

    res.json({ clientSecret: paymentIntent.client_secret });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
