Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF41C34156
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 10:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFDIOx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 4 Jun 2019 04:14:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43830 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfFDIOt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2019 04:14:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so211406pfg.10
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2019 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jV8VCHbj6Lro7TEgyHmuW7nfZ6KFGO5pn05b2o6Dgbc=;
        b=pA4q1aPO8wMBceIMuXHnOPs76k27i1v3HVZe3OwTff0Uk2bwwhPFnu0KC3WuR8DbH/
         9w//GwDJeRxrS0rTh0SXzdvWeGVZ1VhgS2slFROTSH00X4uM9SQN0HX366tQlowjAHVC
         A0/bdTjSJnoKpFyEiixiNEVytwUWAO5WtmcOr9iUdqUMzKxZZQ42fSyB43Xp8mpZSa6C
         nbV9mcCGlv33QQrUS6I+IgCne11HKrnL+QzlMsefZlb++xKAZPYQvXfuAT71o6UbZiaA
         uE6c0QB8KkiK/pL4WV6phIA1mdodo8jgXn3ay2M5KnKla72LPKtnAXWsI5zVjRH3syqk
         645g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jV8VCHbj6Lro7TEgyHmuW7nfZ6KFGO5pn05b2o6Dgbc=;
        b=GgAyjBIN8EhG28DMu5dZXqMZ0YUizIX1B9ky/m1oJtF0Nae6q5nhixmcbYEUFChzsL
         HnCqI/79AuQ2iPLEnlQN7P79Iu1XvChpd4fm4bTb9aBRfOPijCBvvI4GygwZNwuH0gtg
         1l2fCPEbKJhNy8OZ0yUoWqama9TDych10fsqzXLk9Q0M/xoLCMfsRTNUYJvbQPwr46ki
         /JRj0DSrmOhC311CMUh+tcWHXnHqcXYbQH9BRstvbFcUlCkq3AJb26HUSLK5MBnmqgV7
         Xb/OCGEjnfrY7VL1j33YECpiprQ/NwQx7B8xoE4SxS9hPmzae00QUiFoWpQ7uewprL/0
         2ung==
X-Gm-Message-State: APjAAAVGHBxMLkwbUTGJil5s7R4rXjH9pwwPkGBetsSWIeGiiWWFaI/v
        lqMfTFX0iS5w6Z8cm44UP//Fqw==
X-Google-Smtp-Source: APXvYqyBT1jr5sCtI1Qrr8XvCjo0MKf4W3aMfwPavowCyU4VjHK9RS0I0j58WrwdIf8NNGx3+0mwsw==
X-Received: by 2002:a62:e303:: with SMTP id g3mr35873984pfh.220.1559636088227;
        Tue, 04 Jun 2019 01:14:48 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.14.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:14:47 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/9] Add SD host controller support for SC9860 platform
Date:   Tue,  4 Jun 2019 16:14:20 +0800
Message-Id: <cover.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set adds optional clock support, HS400 enhanced strobe mode support,
PHY DLL configuration and other optimization to make the SD host controller
can work well on the Spreadtrum SC9860 platform.

Changes from v1:
 - Add acked-tags from Adrian.
 - Fix one mistake by changing MMC_TIMING_MMC_HS to MMC_TIMING_SD_HS in patch 8.

Baolin Wang (9):
  mmc: sdhci-sprd: Check the enable clock's return value correctly
  dt-bindings: mmc: sprd: Add another optional clock documentation
  mmc: sdhci-sprd: Add optional gate clock support
  mmc: sdhci-sprd: Implement the get_max_timeout_count() interface
  mmc: sdhci-sprd: Add HS400 enhanced strobe mode
  mmc: sdhci-sprd: Enable PHY DLL to make clock stable
  dt-bindings: mmc: sprd: Add PHY DLL delay documentation
  mmc: sdhci-sprd: Add PHY DLL delay configuration
  arm64: dts: sprd: Add Spreadtrum SD host controller support

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |   19 +++
 arch/arm64/boot/dts/sprd/whale2.dtsi               |   35 ++++
 drivers/mmc/host/sdhci-sprd.c                      |  171 +++++++++++++++++++-
 3 files changed, 217 insertions(+), 8 deletions(-)

-- 
1.7.9.5

