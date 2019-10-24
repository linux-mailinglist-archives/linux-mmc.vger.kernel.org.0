Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4AEE3557
	for <lists+linux-mmc@lfdr.de>; Thu, 24 Oct 2019 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405827AbfJXORG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 24 Oct 2019 10:17:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36926 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405266AbfJXORG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Oct 2019 10:17:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id l21so25232624lje.4
        for <linux-mmc@vger.kernel.org>; Thu, 24 Oct 2019 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dtimneKwZFaF54dqtcoEKY8+n6XFTvEBBrlWCqK7fY=;
        b=oJAYezc1bgKTMdgLa9qNaR8lT9SS+495i8haekqFB1/rkGC0+6UuYWNuf63eI+pbmh
         oOidcoHdT+SwY+laPj9kNjvOCA2CxLqSrIcUw3nAPRUU/04lyI//pBBSvFx5Hp0+B985
         7MeiKoPyYr9gzykuFoCoGtmVtYFBJa2a3kL/dWK/dCVaj+7EyeuyHAbLMHhQsRUcyM3x
         ApXFh6cEPJLnJiVzc1cZFFOXsHTNf0c4Xf2WEI/rtUTVriqFUsQjguktSE+gV0NA1tap
         CqRviFwlZcKj1i0jEFtUwXQw55vwN3T3lwWibMxVwt7Ly+AfgZ44YODf5MFcNIa1aNnY
         4JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dtimneKwZFaF54dqtcoEKY8+n6XFTvEBBrlWCqK7fY=;
        b=uO++lHMN4LCX6uPvgz9iXAnGuPXi7MKo77Wv2O5Nl3BFeHFJR7jTqcwB28Bb5AZ54x
         Icd/8fTaupeEar4AF3yf6sCecOnap7FOHkywu5RNoPxCP0JUj+sR0V5ucLmXvKWoO8PL
         suIbNIQ99kqGne42ykdJHecr1lgOWUlrlWirATko6IbqMDFlYFHH9k9SB1h6Kyyx/qaX
         1v+sdov4lMrVnsYcdDlixJ1tAypOXJ+IYwFsFqUKF+yV1qXlSzpfAdiiRw0lFZjY6SXc
         +EvRq0l2mOivCkcPAoMKdb24qwB2YbKWiDNUeDNqRKX2X/SEAqP8AKBQpRcsIWjuo4fy
         CU0w==
X-Gm-Message-State: APjAAAW4NE+QzUhTrJxr/ZuaSDGsbGlHrAp57MTQ2OmEYw2q6pvL+eM7
        pYsLrsNnac3+UmUhNH/Y+/LIvljr
X-Google-Smtp-Source: APXvYqwADThQquSG3lSqSJDn566KixVfa+IozVKEffGOH0TMmh9mT0mkjU67/TbK1OSmrfOFy0ZF0Q==
X-Received: by 2002:a2e:8204:: with SMTP id w4mr295131ljg.3.1571926623953;
        Thu, 24 Oct 2019 07:17:03 -0700 (PDT)
Received: from laped.kamstrup.dk ([185.181.22.4])
        by smtp.googlemail.com with ESMTPSA id b20sm10692267ljo.106.2019.10.24.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 07:17:03 -0700 (PDT)
From:   Lars Pedersen <lapeddk@gmail.com>
To:     linux-mmc@vger.kernel.org, michael.heimpold@i2se.com,
        avri.altman@wdc.com
Cc:     Lars Pedersen <lapeddk@gmail.com>
Subject: [PATCH v2 0/1] mmc-utils: AUTO_EN and MANUAL_EN in BKOPS_EN
Date:   Thu, 24 Oct 2019 16:16:33 +0200
Message-Id: <20191024141634.19287-1-lapeddk@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch adds support to enable AUTO_EN and MANUAL_EN in the BKOPS_EN
register. AUTO_EN is only supported in eMMC 5.1+.

In v2:
- Added signed-off-by for patches
- Dropped patch for BKOPS start support, since its already controlled in the host
  controller. (mmc_run_bkops)

Lars Pedersen (1):
  mmc-utils: Support MANUAL_EN and AUTO_EN in BKOPS_EN register

 mmc.c      | 14 ++++++++----
 mmc.h      |  7 ++++--
 mmc_cmds.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 mmc_cmds.h |  3 ++-
 4 files changed, 80 insertions(+), 10 deletions(-)

-- 
2.21.0

