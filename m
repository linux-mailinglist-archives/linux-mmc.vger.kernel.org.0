Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D7592D9C
	for <lists+linux-mmc@lfdr.de>; Mon, 15 Aug 2022 12:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiHOK70 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 15 Aug 2022 06:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiHOK7U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 06:59:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251FF17ABE
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660561160; x=1692097160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cxFhGBOJsmCKHKIqllvCqaNNwS3Y0fDQbyO+BoLgcNw=;
  b=abuQQroC/+ACxJqVFwyjLwVqX4tvOkHiuBQ4BEmEY58xpP/Vo8bv3QN2
   +FiJCHt51mVi8lwiypjC3FJBuHgcueip4HD4QJFq0p9ZV4X+pUsZdvMOv
   KBLOHorojlLkvVmcoDZAUjIoiG8X9ZTwZws1R19+ZooyqPil0GhxUJkd7
   yZfEGLRjkRjOqZeYmQ3F8dKsofYZNi0eui0YKEVHZ7WZkMFTA+Tn5ZcNy
   1rjNNp9o1Gfhr4BZG8q/0F5gaT3aQyLUAujWYvX9UGWuYmPwTXmg4kB0g
   XVPtCQAFF6kJgKah79IPhs4MeWujVf2WY2i/kA0D6M5RDH0ioyzXw7kXo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="290689059"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="290689059"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 03:59:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="603149063"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.50.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 03:59:18 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: sdhci: Update MAINTAINERS Maintained -> Supported
Date:   Mon, 15 Aug 2022 13:59:05 +0300
Message-Id: <20220815105905.65188-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Currently, status is "Supported" not "Maintained" for SDHCI and CQHCI.
Amend MAINTAINERS accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f679152bdbad..4f804357f3a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7414,7 +7414,7 @@ M:	Adrian Hunter <adrian.hunter@intel.com>
 M:	Ritesh Harjani <riteshh@codeaurora.org>
 M:	Asutosh Das <asutoshd@codeaurora.org>
 L:	linux-mmc@vger.kernel.org
-S:	Maintained
+S:	Supported
 F:	drivers/mmc/host/cqhci*
 
 EMULEX 10Gbps iSCSI - OneConnect DRIVER
@@ -17995,7 +17995,7 @@ F:	drivers/mmc/host/sdhci-brcmstb*
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
 M:	Adrian Hunter <adrian.hunter@intel.com>
 L:	linux-mmc@vger.kernel.org
-S:	Maintained
+S:	Supported
 F:	drivers/mmc/host/sdhci*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
-- 
2.25.1

