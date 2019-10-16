Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D51D8F19
	for <lists+linux-mmc@lfdr.de>; Wed, 16 Oct 2019 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392662AbfJPLQX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Oct 2019 07:16:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46443 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfJPLQW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2019 07:16:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id d1so23512136ljl.13
        for <linux-mmc@vger.kernel.org>; Wed, 16 Oct 2019 04:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=da9w0gtxh3i15lub4msX8H2Vh5hDA6Z1nNMg2rZtQfs=;
        b=SnESXsVHRtRgYKjh73HbQ2VJsFrJBDJZR8mjYHSMaoSh6X7JvVhCigS/pGRxv4UyIQ
         nokjxOPec2unebMIMQppm0ZjAm9S7aOaGv98Q8tr9tzh/G/jyurpuI4ElrtXFQwiCxg+
         H9eUqYOGxd7Ee8D4lNtxcUoJ711zb2sAThoM7HJmAJ2pEkT98cBi+w9emlSQsDf9Z1Oq
         evnCVEtI/m1MfBNgxzb4JqRZ/JTIbbeJX3+aP/qBVa2M9VxetSM/998qvSCD/fplSjat
         WAiN4ya23eijZqv4SkaGB+qsO35YuxRayNzyAePSX6DaWK1N3LfAARYun0a0t8V3hEfM
         f/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=da9w0gtxh3i15lub4msX8H2Vh5hDA6Z1nNMg2rZtQfs=;
        b=aLbTqazuzxJG8WQoPmVN3jS9alvrv3jfEieYhXCZClIAmHAbKrSrraT5Ac9oA5vF1p
         KmXM01duBTbYf8TMm1fbJo8JqyelXHZ1JkG9KfIo0cYudP5EuYbx0omk6ee7YPH/rJzE
         uVVfFmeJGDYRJGvO3R9GAIorhyq7nEvC6N8mZLFzPYgAkRPsm3ZPLgyb3ukqdYeyrGqP
         d5QCechdbWHfAikYz1M+8qaZK5gqmLGH84DGXq/a7iBazJkdPgYL/KU5w/pYvHdFM+G3
         p/X1W4HWSFtMf2KdgsjPWO1DyH09stOzgVWtrfrbEgBtLKiImt+A47QM+mR5XiAiezng
         1BKg==
X-Gm-Message-State: APjAAAU+CIE+8OyFo8Bz6ESyuPxd+pVqBG40iF3Sj7rDVsf5ZmWdB+Ik
        Aw+9F21AU8XZcj5L/tV4RCLmei9g
X-Google-Smtp-Source: APXvYqynLltwrcRYUiMCacE/kQifTrJtZvdHTiHF4wUIXEH/H4NccPbNrNzQzEwtXpzSXtU/WAKQ8g==
X-Received: by 2002:a2e:908d:: with SMTP id l13mr23864277ljg.165.1571224579826;
        Wed, 16 Oct 2019 04:16:19 -0700 (PDT)
Received: from laped.kamstrup.dk ([185.181.22.4])
        by smtp.googlemail.com with ESMTPSA id b21sm6544729lff.96.2019.10.16.04.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 04:16:19 -0700 (PDT)
From:   Lars Pedersen <lapeddk@gmail.com>
X-Google-Original-From: Lars Pedersen <laa@kamstrup.com>
To:     linux-mmc@vger.kernel.org, avri.altman@wdc.com,
        michael.heimpold@i2se.com
Cc:     Lars Pedersen <lapeddk@gmail.com>
Subject: [PATCH 0/2] mmc-utils: BKOPS_EN auto, manual and start
Date:   Wed, 16 Oct 2019 13:15:40 +0200
Message-Id: <20191016111542.31358-1-laa@kamstrup.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Lars Pedersen <lapeddk@gmail.com>

This patch series adds support to enable AUTO_EN and MANUAL_EN in the
BKOPS_EN register. The AUTO_EN has been added in eMMC 5.1 standard.
BKOPS start has also been added if MANUAL_EN is used/set. The MANUAL_EN
can still be used like before for eMMC standard older than 5.1.

Lars Pedersen (2):
  Support MANUAL_EN and AUTO_EN in BKOPS_EN register
  Support for bkops start when manual background operation is used.

 mmc.c      |  19 +++++++--
 mmc.h      |  12 +++++-
 mmc_cmds.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 mmc_cmds.h |   4 +-
 4 files changed, 137 insertions(+), 10 deletions(-)

-- 
2.21.0

