Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B322B595
	for <lists+linux-mmc@lfdr.de>; Mon, 27 May 2019 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfE0MnN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 27 May 2019 08:43:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52156 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfE0MnN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 May 2019 08:43:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id f10so8600238wmb.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2019 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKi6i530JJNrkfWp8zdTE/DlNf+AJ6vpEuNiHI586GM=;
        b=F0OuPbcaU47Vw5cIofDI7N8sCg5q5HjGbe75cSt5fxbmgeL/gwFfe0z2Wex7Xk06+v
         KyG3eIWcX65wfRkP5yFfwX2MTmFf4YvIPSZ1sfR1vF1vL5KWjLpfqFxNLMzGW92WyTZ0
         xQHBioJ2CSnMfPDUutyRdQFF8edHOg7JnkFzKVpAXmvHIL4ES9prSLURjwD+JEwbDGxK
         ixEefmZ8lZXsS+0UWbqOEroGQcLF9GJipI2ge/K4pAZ7ZxZs8O4K2GqhChbwBA2HoQIf
         KPQrFoIVhCSob5K6Aky/XPD+3Qw/jM0QmRhk1va3R4IzLIYlAEQiAuh2kDeG0+YVUM8H
         IzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKi6i530JJNrkfWp8zdTE/DlNf+AJ6vpEuNiHI586GM=;
        b=PkEZu3CZWLrhbfAirvzBq50YxmGYHxxbuFiRhVyl/uyE0k5GL/dyGx7rmyT/FN348q
         /DUHt+ORiZ8bDom93EO24u7XQoa9LpU7MFih846xKhZ+aQJW3hNZUVKGcewIpTSZDnQ8
         Ums7dTD5m/rVRezh1CafRRESW4uD6p9Xvg/x5fa9k0a+zyBArLhl52kLXqKb+fB8HNCK
         qQWss9oOm98cMYCpTfscEoHDbTkx93lWDFGg+OqOmh9+tWzefIgxt9aVcRYfuA4tIzDw
         87aROi1Lh1FoYXvN+vtLXtyeR1zxn3TmJZ3XM2eL4bDcMwKAaiakvpJLxk/odGO66HL0
         kDJQ==
X-Gm-Message-State: APjAAAXfEAO8BAwF5x85Agva1KkBpzkTAduGcQjaqXcW/SfCx6mfd+Lv
        vywDlmYdMddc3UA03DstoiWM5A==
X-Google-Smtp-Source: APXvYqwLlj5CMrnZHpa7NOKgj27nP4BBbZEUNpyia+Gjsf8jHnw5YAJDwN7ERYC5zPTVIVnhO1qS3g==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr9242682wmf.35.1558960990603;
        Mon, 27 May 2019 05:43:10 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm11494930wrt.45.2019.05.27.05.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 05:43:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] mmc: meson-gx: add dram-access-quirk support
Date:   Mon, 27 May 2019 14:43:04 +0200
Message-Id: <20190527124307.32075-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
the data from DRAM, leading to a broken controller.

Add the amlogic,ddr-access-quirk property so signal this particular
controller has this bug and needs a quirk to work properly.

But each MMC controller has 1,5KiB of SRAM after the registers, that can
be used as bounce buffer to avoid direct DDR access from the integrated
DMAs (this SRAM may be used by the boot ROM when DRAM is not yet initialized).

The quirk is to disable the chained descriptor for this controller, and
use this SRAM memory zone as buffer for the bounce buffer fallback mode.

The performance hit hasn't been evaluated, but the fix has been tested
using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
at 50MHz clock. It gave around 170 Mbits/sec as SDR104 and 200MHz clock.

Changes since v1:
* use DRAM instead of DDR, added details in bindings on internal DMA controller
* fix probe() to not try to unallocate bounce buffer on error
* replace DT patch adding SDIO property to patch adding SDIO controller

Jerome Brunet (1):
  arm64: dts: meson: g12a: add SDIO controller

Neil Armstrong (2):
  dt-bindings: mmc: meson-gx: add dram-access-quirk property
  mmc: meson-gx: add dram-access-quirk

 .../bindings/mmc/amlogic,meson-gx.txt         |  4 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 37 ++++++++++
 drivers/mmc/host/meson-gx-mmc.c               | 70 +++++++++++++++----
 3 files changed, 96 insertions(+), 15 deletions(-)

-- 
2.21.0

