Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A474E05D
	for <lists+linux-mmc@lfdr.de>; Fri, 21 Jun 2019 08:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfFUGMv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 21 Jun 2019 02:12:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32942 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfFUGMv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jun 2019 02:12:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so2228360pgk.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2019 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hc7LlnhYKlripj8xIjUSqdLS+0TxDwaADDzz2U0auf4=;
        b=zVvpyVBj1fJ344KOE4nUWG+7s5KWzpfOGopnV2cFnegqyPWrCuMoxxX5v9HH9Z5msi
         N+J6AD7cAuJIKQSVYE4eCOBxlRNxKKlEfoKXWCdtKYRLsKnaFQGQhfcaPOo4UKJVgZgK
         YLlilwII4SMLYxedxWDej8qvRFt9apfjzAZ5YWe8JdxKcqQzRCWNFlC8WpUSUJNerk9s
         87e4tSDIkvdWO0XeezqDlD/2W8YEFn/gCClGB6eAmReP+Mjb/ECtelZA9y3w8YukhTzX
         PGGG/3c8JxaIjGdLnwQnIfiP5eo8MTaf6AQDcw9BJ/b4GAS6IhnLQLehh+TOV9g30aSz
         OPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hc7LlnhYKlripj8xIjUSqdLS+0TxDwaADDzz2U0auf4=;
        b=WtznhAhPHkE/mgUK73f6OIEdtogQp0/mCtjcY4tqLUe4Mfo7PwarejvrOL9gXXsyBh
         AOymXpDTDCB6VGM7sNrv2E3FnrxRStUheYS4XUpUDh3HOyg8oWKZuFFYdWUvzR1jh+rq
         oqem4GUcLSnpG9BO2ppFRDc7gV9SJ2AvGg4ZhDlBN+o+PBbQpGurXbG34L2TeHQJaj3i
         FjnjEERucaLQKxPw6+DXmmLFirZGa636YpEqIU6+eTZLBqEIFsXArkyxL9d7X4mgvREt
         dCcTN3fuuKSVmKda6qESfgL6r1dlApXY4rlvgG3FdJhoL6SN4s6LBjr44AYA55UGMv6+
         /mgQ==
X-Gm-Message-State: APjAAAXHKehVensbcnyXKcXUrw5ulu3nJ/9X+lFgG37bsZPpEJ2sEEL7
        5Zc0tHOFe+HhkD+8AYDa3MZyXQ==
X-Google-Smtp-Source: APXvYqz+VB2OyxZohTciMXy6FWLRoUom4/hSeT25jg2KnM8hP9F1uMaTXlETllBlDuISal0kQwrtzA==
X-Received: by 2002:a63:3d0f:: with SMTP id k15mr16737667pga.343.1561097570369;
        Thu, 20 Jun 2019 23:12:50 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x7sm1266134pfm.82.2019.06.20.23.12.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 23:12:49 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/3] Optimize voltage switch for the SD controller
Date:   Fri, 21 Jun 2019 14:12:30 +0800
Message-Id: <cover.1561094029.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set is used to optimize voltage switch for the
Spreadtrum SD host controller.

Any comments are welcome. Thanks.

Baolin Wang (3):
  mmc: sdhci-sprd: Add start_signal_voltage_switch ops
  dt-bindings: mmc: sprd: Add pinctrl support
  mmc: sdhci-sprd: Add pin control support for voltage switch

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |    7 ++
 drivers/mmc/host/sdhci-sprd.c                      |   78 ++++++++++++++++++++
 2 files changed, 85 insertions(+)

-- 
1.7.9.5

