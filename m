Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153C01D4C69
	for <lists+linux-mmc@lfdr.de>; Fri, 15 May 2020 13:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgEOLTr (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 15 May 2020 07:19:47 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:49159 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgEOLTq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 07:19:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589541586; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=G0YIFY7DmGhaD5zdzMpjeUqrJeIdM8P3XbRXyIYmxlI=; b=M2V6UgYhlW4JYiLtWf8XVD3wSOHXdI/VA8vTBEYtxj6G1yH3d75sL+5ju+ugOsEWMzgVi34f
 lI+C7cxH9tHjM8iq5lmKJNX4tgQJqeOnQMFnD6jgLqprz7ytDeIfnR0s3LiD8AiywGRQSWk0
 cIJH/FzLioi7BYVkwhjzzvIXjE8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebe7ac9.7f337dc55998-smtp-out-n02;
 Fri, 15 May 2020 11:19:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 89746C433F2; Fri, 15 May 2020 11:19:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A952C433D2;
        Fri, 15 May 2020 11:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A952C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V1 0/3] Internal voltage control for qcom SDHC 
Date:   Fri, 15 May 2020 16:48:51 +0530
Message-Id: <1589541535-8523-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On qcom SD host controllers voltage switching be done after the HW
is ready for it. The HW informs its readiness through power irq.
The voltage switching should happen only then.

So added support to register voltage regulators from the msm driver
and use them.

This patchset was posted long back but not actively pursued
https://lore.kernel.org/linux-arm-msm/1539004739-32060-1-git-send-email-vbadigan@codeaurora.org/
So posting it as fresh patchset.  

Veerabhadrarao Badiganti (1):
  dt-bindings: mmc: Supply max load for mmc supplies

Vijay Viswanath (2):
  mmc: sdhci-msm: Use internal voltage control
  mmc: sdhci: Allow platform controlled voltage switching

 .../devicetree/bindings/mmc/mmc-controller.yaml    |  16 ++
 drivers/mmc/host/sdhci-msm.c                       | 215 ++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                           |  32 +--
 drivers/mmc/host/sdhci.h                           |   1 +
 4 files changed, 243 insertions(+), 21 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
