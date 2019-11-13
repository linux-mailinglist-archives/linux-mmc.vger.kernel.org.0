Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F750FAB58
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Nov 2019 08:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfKMHxo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 13 Nov 2019 02:53:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45245 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfKMHxo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2019 02:53:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so1400035ljg.12
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2019 23:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqEmLAzEQb9ps3ZlETCYtkOJ5L4AjuKlcBGtyB1ev2Y=;
        b=URdTYiPPZI+OHS8Y85BIshRaCjUVitFN0qeuAdugtAmJ8F9vgjtPkpCYsrV87m+UkL
         p3JzfSgYlS2qcthS7lixjMyYDeQAxpoEV4a65ZAhImKWQFu3Lr8oa5460070EyWTu13F
         u1KXR0ZcAMwMjhwgoxYWSipM8okmYD1J4/eUTBwXp3QhSRsv8/uUNAxEc2UIHjcGSy0D
         KrGfJKOJGZUKPYTlXuHNChKn/484p7Diy/9zc2WKOALA5QCp6iYOdyKyowuD77Qhggwy
         V5VaZievWht7aKQhV3v/IXDKbLosRF1SYib2iZ+rVV3s+l4uY8Qj5oVNuNCwDiGNg/hp
         1CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqEmLAzEQb9ps3ZlETCYtkOJ5L4AjuKlcBGtyB1ev2Y=;
        b=kBC/cWPraOsbgnxr4QP4uCZcr01lWgaZU4x74cVm8U8FWbS+aRID3KvFZgeazFbdOe
         GHgx9OTg9IntgqZmTK2uJCunTK/sutwoyD+IHIcDtR3BMNWEuL8jri8r1/99KfSJB3oi
         6vUZC5YHwia+gOMjXYl9ue4e5LcwcHyRnk2m9VLZy5VIezbufmXRqYg3czq4AOpZszVz
         PfPr9AnkahG3HoUZADRwwKrI+As7uSsZqwryjzOywEgz3im01k1/yJdfprou/dc+P5Z/
         fgGMegduaiucUNdKFGLqQwrw70rRFo9fIX851SL5pD1NyanbgIuNhAB+sm3p52a86X5A
         kJ1Q==
X-Gm-Message-State: APjAAAX1+ZsbFyukUN47o0/KAxk6sfm78O3JJLb+05yfgwo8Jk5aLpgV
        ylsCGA/MniMXb911u+EbyyLRPw==
X-Google-Smtp-Source: APXvYqxT+481QIW+ft1eL3zgVvBTr68GKAFTc1+PVVpmCMb21pTHaXGVZsUUj8P2J0TlZe8yQCUOlg==
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr1567752ljq.20.1573631621703;
        Tue, 12 Nov 2019 23:53:41 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id j10sm610110lfc.43.2019.11.12.23.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 23:53:40 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/3] MMCI odd buffer alignment fixes
Date:   Wed, 13 Nov 2019 08:53:32 +0100
Message-Id: <20191113075335.31775-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is an attempt to fix the three independent issues seen
by Ulf in the MMCI driver.

I am unable to test patches 2 & 3 since I can't provoke the
right traffic, but I hope Stephan can try it with his
Broadcom WiFi.

Linus Walleij (2):
  mmc: mmci: Bail out from odd DMA on Ux500
  mmc: mmci: Proper PIO residue handling

Ulf Hansson (1):
  mmc: mmci: Support odd block sizes for ux500v2 and qcom variant

 drivers/mmc/host/mmci.c | 166 ++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/mmci.h |  18 ++++-
 2 files changed, 169 insertions(+), 15 deletions(-)

-- 
2.21.0

