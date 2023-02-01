Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6278D6820F2
	for <lists+linux-mmc@lfdr.de>; Tue, 31 Jan 2023 01:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjAaAqn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 30 Jan 2023 19:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAaAqm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2023 19:46:42 -0500
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A72A146
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 16:46:39 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id D469A280199;
        Tue, 31 Jan 2023 08:46:35 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/3] Some features and fix for sdhci-of-dwcmshc
Date:   Tue, 31 Jan 2023 08:46:28 +0800
Message-Id: <1675125991-189452-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUJJVkodSUpIQh9IS01JSVUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PD46Cww5Cj0PHD86Pi04DBAN
        FU8KChpVSlVKTUxOSklOQkJNT0pJVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpIQ0w3Bg++
X-HM-Tid: 0a86054a39ca2eb1kusnd469a280199
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


This patchset has 3 patches. The first one is a signal improvement
actually. Then we add runtime time support and hsq support which have
been tested in vendor kernel for a long time.



Shawn Lin (3):
  mmc: sdhci-of-dwcmshc: Update DLL and pre-change delay for rockchip
    platform
  mmc: sdhci-of-dwcmshc: Add runtime PM support
  mmc: sdhci-of-dwcmshc: Add host software queue support

 drivers/mmc/host/sdhci-of-dwcmshc.c | 93 ++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 6 deletions(-)

-- 
2.7.4

