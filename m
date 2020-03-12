Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A60371832DB
	for <lists+linux-mmc@lfdr.de>; Thu, 12 Mar 2020 15:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgCLOYx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 12 Mar 2020 10:24:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:32517 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgCLOYx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Mar 2020 10:24:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 07:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="266348015"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2020 07:24:51 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Seo@vger.kernel.org, Kyungmin <kyungmin.seo@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH RFC 0/3] mmc: core: Do not change frequency before switch from HS400
Date:   Thu, 12 Mar 2020 16:24:02 +0200
Message-Id: <20200312142405.9813-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

Patches to improve mmc_hs400_to_hs200() as discussed here:

	https://lore.kernel.org/linux-mmc/d355ac11-21d6-e8f7-d03f-65c55e10aea2@intel.com/


Adrian Hunter (3):
      mmc: core: Try harder if transfer mode switch fails
      mmc: core: Do not check CRC response for switch from HS400 to HS200
      mmc: core: Do not change frequency before switch from HS400

 drivers/mmc/core/mmc.c     | 41 ++++++++++++++++++++++++-----------------
 drivers/mmc/core/mmc_ops.c | 13 +++++++++++--
 drivers/mmc/core/mmc_ops.h |  2 +-
 3 files changed, 36 insertions(+), 20 deletions(-)


Regards
Adrian
