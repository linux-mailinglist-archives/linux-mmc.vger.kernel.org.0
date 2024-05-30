Return-Path: <linux-mmc+bounces-2246-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209858D439B
	for <lists+linux-mmc@lfdr.de>; Thu, 30 May 2024 04:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61861F246A0
	for <lists+linux-mmc@lfdr.de>; Thu, 30 May 2024 02:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49B61CAB7;
	Thu, 30 May 2024 02:15:39 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2991C693;
	Thu, 30 May 2024 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717035339; cv=none; b=oCs0V611KpiEnYtXFi8Swmt5t3pyPJQYycS/o+HcwWuJzaO097IckOtvTsgYnH67dwjg0e6CMmUaIYzH2bSlYQ2wBBlo4EuRYk6CL6FfKrwIYjtGRFoUHuQcwuyJdsApJDULWijbEkN2DW39WuxYfpfUG7lch/cuTulFE9dqCVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717035339; c=relaxed/simple;
	bh=6wAe6PDwPoPRbuAdisd3AgoRY7qZA25aGbQfD/XuvsY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iF/poW5jiWccKJQebTxrbR5KxgAqfMtimToSpxOIPyZc6svXa7OZico+sCzC2zZ5xY4XaE2blo9XIgC3eSiOgTDVnGK6UnaAk8drCIQCyu3xOVHth6UyT90MZ4AnTpC/yaSDp05bwYvKKGw3aVeKGo3bKmZ6Hw8z0SvxuqPl15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sCVKD-000000004iN-1qwQ;
	Thu, 30 May 2024 02:15:29 +0000
Date: Thu, 30 May 2024 03:15:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>, Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH v2 7/9] mmc: core: set card fwnode_handle
Message-ID: <f02d242f41294bf632eb1db8bd9d7959911f9784.1717031992.git.daniel@makrotopia.org>
References: <cover.1717031992.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717031992.git.daniel@makrotopia.org>

Set fwnode in case it isn't set yet and of_node is present.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mmc/core/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 0ddaee0eae54..e1c5fc1b3ce4 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -364,6 +364,8 @@ int mmc_add_card(struct mmc_card *card)
 
 	mmc_add_card_debugfs(card);
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
+	if (card->dev.of_node && !card->dev.fwnode)
+		card->dev.fwnode = &card->dev.of_node->fwnode;
 
 	device_enable_async_suspend(&card->dev);
 
-- 
2.45.1

