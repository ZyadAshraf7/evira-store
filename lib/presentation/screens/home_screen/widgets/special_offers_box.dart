import 'package:carousel_slider/carousel_slider.dart';
import 'package:evira_store/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';

class SpecialOffersBox extends StatelessWidget {
  const SpecialOffersBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return CarouselSlider(
      items: cubit.specialOffers.map((offer){
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 32, right: 12,top: 12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: AppTheme.grey300,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(offer.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: AppTheme.primary500)),
                            const SizedBox(height: 8),
                            Text(offer.subtitle,
                                style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 8),
                            SizedBox(
                                width: 150,
                                child: Text(
                                    offer.content,
                                    style: AppTheme.bodySmallMedium))
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 2,
                        fit: FlexFit.loose,
                        child: Image.asset(offer.imagePath),
                    )
                  ],
                ),
              ],
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(cubit.specialOffers.length, (index) {
                return Container(
                  width: cubit.index == index ? 20.0 : 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(20),
                    color: cubit.index == index
                        ? AppTheme.primary500
                        : AppTheme.grey400,
                  ),
                );
              }),
            ),
          );
  },
),
        ],
      );
    }).toList(), options: CarouselOptions(
      // aspectRatio: 3/2,
      disableCenter: true,
      padEnds: false,
      aspectRatio: 2,
      viewportFraction: 1,
      enableInfiniteScroll: false,
      animateToClosest: false,
      autoPlay: true,
      onPageChanged: (page,_){
        cubit.specialOfferChanged(page);
      }
    ));
  }
}
