import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart' hide CreditCardModel;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_app/bloc/payment/payment_bloc.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/models/credit_card.dart';
import 'package:stripe_app/widgets/widgets.dart';

part 'home_view.dart';
part 'payment_completed_view.dart';
part 'card_view.dart';
