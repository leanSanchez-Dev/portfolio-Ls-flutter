import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';
import 'package:portfolio_ls/data/datasources/portfolio_bento_local_datasource.dart';
import 'package:portfolio_ls/data/repositories/portfolio_bento_repository_impl.dart';
import 'package:portfolio_ls/domain/models/portfolio_bento.dart';
import 'package:portfolio_ls/providers/portfolio_bento_provider.dart';

void main() {
  test('AppColorsExtension copyWith + lerp + ThemeData registration', () {
    final theme = ThemeData(
      extensions: const <ThemeExtension<dynamic>>[AppColorsExtension.dark],
    );
    final ext = theme.extension<AppColorsExtension>();
    expect(ext, isNotNull);
    expect(ext!.bgCanvas, const Color(0xFF090A0F));
    expect(ext.accentPrimary, const Color(0xFF6366F1));

    final lerped = AppColorsExtension.dark.lerp(AppColorsExtension.light, 0.5);
    expect(lerped.textPrimary, isA<Color>());
    expect(
      AppColorsExtension.dark.copyWith(accentPrimary: Colors.red).accentPrimary,
      Colors.red,
    );
  });

  test('PortfolioBento local data and filters', () {
    final provider = PortfolioBentoProvider(
      const PortfolioBentoRepositoryImpl(PortfolioBentoLocalDataSource()),
    )..load();

    // 6 ESD + 7 legacy
    expect(provider.data.projects, hasLength(13));
    expect(provider.data.legacyProjects, hasLength(7));
    expect(provider.data.techStack.length, greaterThanOrEqualTo(18));
    expect(provider.data.copy.navHome.resolveCode('es'), 'Inicio');
    expect(provider.data.copy.navHome.resolveCode('en'), 'Home');

    expect(provider.data.contactEmail, 'Leansanchez14@gmail.com');
    expect(provider.data.profileImageAsset, 'assets/dev_bg.png');
    expect(provider.data.profileImageAltAsset, 'assets/ls_bg.png');
    expect(provider.data.githubUrl, contains('leanSanchez-Dev'));
    expect(provider.data.linkedInUrl, contains('linkedin.com'));

    expect(provider.experiences, hasLength(9));
    final first = provider.experiences.first;
    expect(first.company, 'Sunset Software House');
    expect(first.isCurrent, isTrue);
    expect(first.engagements, hasLength(2));
    expect(first.engagements.first.title.es, 'Fisioterapp');
    expect(first.engagements.first.isActive, isTrue);
    expect(first.engagements[1].title.es, 'Cliente Quipux');
    expect(first.engagements[1].isActive, isFalse);
    final fundaserExp = provider.experiences.firstWhere(
      (e) => e.company.contains('FUNDASER'),
    );
    expect(fundaserExp.period.es, '2026');
    expect(fundaserExp.period.en, '2026');
    expect(fundaserExp.period.es.contains('2025'), isFalse);
    expect(
      provider.experiences.where((e) => e.company == 'CODESA S.A.').single.isCurrent,
      isFalse,
    );

    final fundaser = provider.data.projectById(BentoProjectId.fundacer);
    expect(fundaser, isNotNull);
    expect(fundaser!.title, 'FUNDASER');
    expect(fundaser.company, 'FUNDASER');
    expect(fundaser.imageAsset, isNull);

    expect(provider.data.projectById(BentoProjectId.quipuxCobro), isNotNull);
    expect(provider.data.projectById(BentoProjectId.fisioterapp), isNotNull);

    final bodecom = provider.data.projectById(BentoProjectId.bodecom);
    expect(bodecom, isNotNull);
    expect(bodecom!.imageAsset, 'assets/slide/bodecom.jpeg');
    expect(bodecom.company, 'Comunix S.A.S');

    final portfolio = provider.data.projectById(BentoProjectId.portfolio);
    expect(portfolio!.liveUrl, 'https://portfolio-lean-dev.web.app');
    expect(portfolio.repoUrl, 'https://github.com/leanSanchez-Dev');
    expect(portfolio.imageAsset, isNotNull);

    provider.setTechFilter(TechCategory.mobile);
    expect(
      provider.filteredTech.every((t) => t.category == TechCategory.mobile),
      isTrue,
    );

    provider.setProjectFilter(BentoProjectFilter.ui);
    expect(provider.filteredProjects, hasLength(1));
    expect(provider.filteredProjects.first.id, BentoProjectId.smarttv);
  });
}
