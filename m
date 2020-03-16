Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93519186795
	for <lists+linux-mmc@lfdr.de>; Mon, 16 Mar 2020 10:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgCPJNp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Mar 2020 05:13:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:54785 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730076AbgCPJNp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Mar 2020 05:13:45 -0400
IronPort-SDR: Nv8An2QXeVsAvBF47agCE2fdeJWZgTwsbSWlrrL5YnhXeVHqd9ICDfD2RAlcYOlEzw1yvn6m8Q
 e/pTtnfP2rWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 02:13:45 -0700
IronPort-SDR: VNBHN3O0upaVPoVr8LlfTFK70KmvfzNXLdgpRCaMcA7j0WK9aOL0c2yE9dSWu/KcGWphrnxBJD
 Mr2dWBe1M/Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400"; 
   d="scan'208";a="267499671"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2020 02:13:43 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 0/2] mmc: sdhci-of-arasan: Add support for Intel Keem
Date:   Mon, 16 Mar 2020 17:13:22 +0800
Message-Id: <20200316091324.15968-1-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi.

The first part is to document the new compatible string required
for eMMC, SD and SDIO support in Intel Keem Bay.

The second part is to add the changes required to support the Host
Controller and its integrated eMMC PHY. The significant change is
to disable 64-bit support.

The patch was tested with Keem Bay evaluation module board.

Thank you.

Best regards,
Zainie


Wan Ahmad Zainie (2):
  dt-bindings: mmc: arasan: Add compatible strings for Intel Keem Bay
  mmc: sdhci-of-arasan: Add support for Intel Keem Bay

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |  39 ++++++
 drivers/mmc/host/sdhci-of-arasan.c            | 124 ++++++++++++++++++
 2 files changed, 163 insertions(+)

-- 
2.17.1

