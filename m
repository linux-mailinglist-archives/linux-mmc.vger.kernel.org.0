Return-Path: <linux-mmc+bounces-1775-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3316E8A35F8
	for <lists+linux-mmc@lfdr.de>; Fri, 12 Apr 2024 20:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81EF1F22737
	for <lists+linux-mmc@lfdr.de>; Fri, 12 Apr 2024 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B8F14F9EA;
	Fri, 12 Apr 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqmHn9dQ"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6D14F9D6;
	Fri, 12 Apr 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947679; cv=none; b=Y4CVv8BaUGUbSKfQEt3gdHENi1SCeKRSORhAiCromPlFU9V5tjH2DDkzDXX6xqfQA1ax/z0XkUubau9uTO1QOb8Hjiz0QT3hhLrnphd9ToqkgyQ3i5jUsorkazPlMbXWLqhxboK04vG0AyQOGUi2d90R1cV0CywY+8DrXtQDJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947679; c=relaxed/simple;
	bh=MIApVZon2TPAPOZaRnY1KGcOhiuvd84d9hHnyMVD9PI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pop7wOqBkc7PhpUhS+BHk7crtcBhCuaT43Rmb4jpvzGa2PuMcuYqA2QNTfOtEeVwk1dn8hX6gzL7FL4BMBOPiG9H/BO9jlNt4OBEmkXTf2GUrfBp+0z41uC8x9owJB7LoVOLEGVK9VOHShnbiccV6Le7qayNR0pov6vV37kp/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqmHn9dQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712947679; x=1744483679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MIApVZon2TPAPOZaRnY1KGcOhiuvd84d9hHnyMVD9PI=;
  b=GqmHn9dQhUaICeqQzr9E2pNwy7m1MzncjvISqR/Uv0lhEfiFV699mwY3
   qIu+yx1dTfYumDhYGLQvB/gTGsnuOpty8pz77RQlduYqgpFvQUQYFnW1r
   dPC5CZ/tqw0Go0T4letdp5kGFuRL8DHm6oN5NFHNWtARjZ9s88eJV5cwT
   QzujAyNWvxUPjSOz1jPawG2Bnu6eCEvmRRXfUoW7rtmVmMQPK5y8pqy2f
   e7COmpFara39q1wOZHeVmQ3IpVqfAYMG1RM0/IWtALHJsfA99f1D5qVj9
   HILwGbSHmSFUQZ8kKtrjQfRAyyrSRRc7qEERjiQmevsII5NcUNgSsSABx
   Q==;
X-CSE-ConnectionGUID: Ou1yVE1dT1G6yGISqZwFag==
X-CSE-MsgGUID: nsYZ1gqeSPeJ41xMxJi5Iw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12204632"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12204632"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:47:58 -0700
X-CSE-ConnectionGUID: cfS0mMLMRG2L+bd1WFjBHQ==
X-CSE-MsgGUID: F9Q8sd7zRfi4ykTa4rISmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="58725388"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 12 Apr 2024 11:47:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 03E04169; Fri, 12 Apr 2024 21:47:54 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 0/2] mmc: sdhci-acpi: Spring cleanup
Date: Fri, 12 Apr 2024 21:46:19 +0300
Message-ID: <20240412184706.366879-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two independent cleanups for the driver because of new available APIs.

Andy Shevchenko (2):
  mmc: sdhci-acpi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and
    pm_ptr()
  mmc: sdhci-acpi: Use devm_platform_ioremap_resource()

 drivers/mmc/host/sdhci-acpi.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


