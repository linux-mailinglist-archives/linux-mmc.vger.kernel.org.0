Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B440196287
	for <lists+linux-mmc@lfdr.de>; Sat, 28 Mar 2020 01:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgC1AdR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 27 Mar 2020 20:33:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34171 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgC1AdR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Mar 2020 20:33:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id 26so11336226wmk.1;
        Fri, 27 Mar 2020 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UgeGmbbdDFZ1yAVuUZxJWJWTRxhx6kFSWvFuy98QK0Y=;
        b=nPZnRtbFOHq4ABjsx+SU9IeWj4aOYkh8ly8h4RkOgvebzuMOaTJM5DD7Q/dPreyjQW
         Gfi43dtogGfIJDRrknV6Y3rRRA8jRNnVBULu6pJnZgH7dsQIcLrYiRo1CqUKcPUzsgRS
         a24hKjkakz+kdwazyHTsWpabSps8HkkjSJZEKq/9MIFt3c4dVMmlKv++3eoiZ8m52VYx
         hxhfMxw1mscJ0+5XbGpctWjGsewc7ayCoQgKf5TIN6FgWD8loJDKArudcJ54nmeAniYx
         jQBiTv/cmWToON4WGHPkoYvEHFvfv0RMGa02X0jGmI0HeJSlNFMN4WR788zNtgXUty+w
         PyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UgeGmbbdDFZ1yAVuUZxJWJWTRxhx6kFSWvFuy98QK0Y=;
        b=kv85tcSGa2fVSPKas6yqMfTKA9iDe0JcwjrEORvJNuQ5gdUnmptPyqgmvtPxBs3fMl
         /5cgjHUYgF7I8wZXsXnkZdE5vpMmJIWPYycxb89ACubvWSXElbpFvpxculIigCBcw1wT
         8tk5od/0CvUNV8hABD4w0b3HL1IvVg7rkbNjvyvwiWUTz6Z90hAKtujhGQDsocJJsnxK
         roL7QeAoGR2d+kKHYWButNzMnIBedKOzwqFcA3mmnno2UQTwkaVia3Q2B2F7djxo6tR9
         Met6bOlpsSjRKmQ5jIzHPsotznvSWhiS8jwdP2prLPseSnkXeLk27Fe+VkduJcGhcR9V
         Vt/A==
X-Gm-Message-State: ANhLgQ0w14Pax9aX5WtFgnqfBUm8amSsIL2d33M9A1lbi+yMLoHMgBP8
        Xtnc+1TCYrwg5VQScBquC8I=
X-Google-Smtp-Source: ADFU+vtqzsp3T8UdgcFLVAxXMJeOGibIYMJRJ7SnbYnOozzQNsMt93hZyHjEAUiApeeFFfY3Z/25Wg==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr1369659wmf.162.1585355594476;
        Fri, 27 Mar 2020 17:33:14 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f1sm10346246wrv.37.2020.03.27.17.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:33:13 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org
Cc:     jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v5 0/3] Amlogic 32-bit Meson SoC SDHC MMC controller driver
Date:   Sat, 28 Mar 2020 01:32:46 +0100
Message-Id: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

this is the patchset for a driver for the Amlogic "SDHC" MMC controller
found on Meson6, Meson8, Meson8b and Meson8m2 SoCs.

The public S805 (Meson8b) datasheet has some documentation starting on
page 74: [0]

It's performance is still not as good as the driver from Amlogic's 3.10
kernel, but it does not corrupt data anymore (as RFC v1 did).

Special thanks to the people who supported me off-list - you are
amazing and deserve to be mentioned here:
- Xin Yin who helped me fix two more write corruption problems. I am
  hoping that he will reply with Reviewed-by, Tested-by and Bug-fixed-by
- Jianxin Pan for sharing some of the internal workings of this MMC
  controller with me
- Wei Wang for spotting the initial write corruption problem and helping
  test this driver on his board. I have his permission to add his
  Tested-by (off-list, he's Cc'ed so if there's any problem he can speak
  up)


Changes since v4 at [4]:
- move the four clkin clock inputs to the start of the clock-names list
  as suggested by Rob, affects patch #1
- fixed #include statement in dt-bindings example in patch #1

Changes since v3 at [3]:
- split the clock bits into a separate clock controller driver because
  of two reasons: 1) it keeps the MMC controller driver mostly clean of
  the clock bits 2) the pure clock controller can use
  devm_clk_hw_register() (instead of devm_clk_register(), which is
  deprecated) and the MMC controller can act as a pure clock consumer.
  This also affects the dt-bindings which is why I dropped Rob's
  Reviewed-by. Thanks to Ulf for the suggestions

Changes since v2 at [2]:
- rebased on top of v5.5-rc1
- added Rob's and Xin Yin's Reviewed-by and Tested-by (thank you!)
- (note: Kevin had v2 of this series in -next for a few days so the
   build test robots could play with it. I haven't received any negative
   feedback in that time)

Changes since RFC v1 at [1]:
- don't set MESON_SDHC_MISC_MANUAL_STOP to fix one of three write
  corruption problems. the out-of-tree 3.10 "reference" driver doesn't
  set it either
- check against data->flags instead of cmd->flags when testing for
  MMC_DATA_WRITE as spotted by Xin Yin (many thanks!). This fixes
  another write corruption problem
- clear the FIFOs after successfully transferring data as suggested by
  Xin Yin (many thanks!). This is what the 3.10 driver did and fixes yet
  another write corruption problem
- integrate the clock suggestions from Jianxin Pan so the driver is now
  able to set up the clocks correctly for all known cases. documentation
  is also added to the patch description. Thank you Jianxin for the
  help!
- set the correct max_busy_timeout as suggested by Jianxin Pan (thanks!)
- convert the dt-bindings to .yaml (which is why I didn't add Rob's
  Reviewed-by)
- switch to struct clk_parent_data as part of newer common clock
  framework APIs to simplify the clock setup
- dropped CMD23 support because it seems to hurt read and write
  performance by 10-20% in my tests. it's not clear why, but for now we
  can live without this.
- use devm_platform_ioremap_resource instead of open-coding it


[0] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
[1] https://patchwork.kernel.org/cover/11035505/
[2] http://lists.infradead.org/pipermail/linux-amlogic/2019-November/014576.html
[3] https://patchwork.kernel.org/cover/11283179/
[4] https://patchwork.kernel.org/cover/11329017/

Martin Blumenstingl (3):
  dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
  clk: meson: add a driver for the Meson8/8b/8m2 SDHC clock controller
  mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host

 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   |   83 ++
 drivers/clk/meson/Kconfig                     |    9 +
 drivers/clk/meson/Makefile                    |    1 +
 drivers/clk/meson/meson-mx-sdhc.c             |  212 ++++
 drivers/mmc/host/Kconfig                      |   14 +
 drivers/mmc/host/Makefile                     |    1 +
 drivers/mmc/host/meson-mx-sdhc.c              | 1064 +++++++++++++++++
 .../dt-bindings/clock/meson-mx-sdhc-clkc.h    |    8 +
 8 files changed, 1392 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
 create mode 100644 drivers/clk/meson/meson-mx-sdhc.c
 create mode 100644 drivers/mmc/host/meson-mx-sdhc.c
 create mode 100644 include/dt-bindings/clock/meson-mx-sdhc-clkc.h

-- 
2.26.0

