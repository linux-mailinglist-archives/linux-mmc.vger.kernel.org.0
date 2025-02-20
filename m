Return-Path: <linux-mmc+bounces-5595-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D2A3D283
	for <lists+linux-mmc@lfdr.de>; Thu, 20 Feb 2025 08:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D673B281B
	for <lists+linux-mmc@lfdr.de>; Thu, 20 Feb 2025 07:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C4C1E9B17;
	Thu, 20 Feb 2025 07:44:37 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90A1E990D
	for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037477; cv=none; b=oKhRyOc6A3n/Q11VK7KtxcTANnUeLwr5QX08ohdvmRmNGXEMjVVjCSkUG8vVSaxq1Yg0YLtBYT6fb3NsqbhBM9oaEKw9t77puwStMStqJE7Pd8ePzNNEAmwgzTns6npSx5bjRJefcqETnlpkPF/eIkFfYbuZnqRp/S276FAdBI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037477; c=relaxed/simple;
	bh=WuI6pUmSfe+p94sU4Rpw02wsR+H+zNTa6n4DhHtZLyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SeorAVH9UIZWzuFYidst6FMlW0iVXU70ycDhkIiVy3om7kKIEWTzUsaJ8EiaQu7IapGu3iTggisQQK5Gh7LJWdBBptBQ4j/aUxGnuoinPBv29n+TQZpXld8gc4EAl0ZQ04ittNVWnRyeyhZ/UXHNURDZKROosfvB8HwFMOryBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EV-0004TO-1C; Thu, 20 Feb 2025 08:44:31 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EU-001tqN-1o;
	Thu, 20 Feb 2025 08:44:30 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EU-00CC1k-1a;
	Thu, 20 Feb 2025 08:44:30 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 0/6] mmc: handle undervoltage events and prevent eMMC corruption
Date: Thu, 20 Feb 2025 08:44:23 +0100
Message-Id: <20250220074429.2906141-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

This patch set introduces a framework for handling undervoltage events
in the MMC subsystem. The goal is to improve system reliability by
ensuring graceful handling of power fluctuations that could otherwise
lead to metadata corruption, potentially rendering the eMMC chip
unusable or causing significant data loss.

## Problem Statement

Power fluctuations and sudden losses can leave eMMC devices in an
undefined state, leading to severe consequences. The worst case can
result in metadata corruption, making the entire storage inaccessible.
While some eMMC devices promise to handle such situations internally,
experience shows that some chip variants are still affected. This has
led vendors to take a more protective approach, implementing external
undervoltage handling as a precautionary measure to avoid costly field
failures and returns.

The existence of the "Power Off Notification" feature in the eMMC
standard itself serves as indirect evidence that this is a real-world
issue.  While some projects have already faced the consequences of
ignoring this problem (often at significant cost), specific cases cannot
be disclosed due to NDAs.

## Challenges and Implementation Approach

1. **Raising awareness of the problem**: While vendors have used
   proprietary solutions for years, a unified approach is needed upstream.
   This patch set is a first step in making that happen.

2. **Finding an acceptable implementation path**: There are multiple
   ways to handle undervoltage - either in the kernel or in user space,
   through a global shutdown mechanism, or using the regulator framework.
   This patch set takes the kernel-based approach but does not prevent
   future extensions, such as allowing user-space handoff once available.

3. **Preparing for vendor adoption and testing**: By providing a
   structured solution upstream, this patch set lowers the barrier for
   vendors to standardize their undervoltage handling instead of relying on
   fragmented, out-of-tree implementations.

## Current Limitations

This patch set is an initial step and does not yet cover all possible
design restrictions or edge cases. Future improvements may include
better coordination with user space and enhancements based on broader
testing.

## Testing Details

The implementation was tested on an iMX8MP-based system. The board had
approximately 100ms of available power hold-up time. The Power Off
Notification was sent ~4ms after the board was detached from the power
supply, allowing sufficient time for the eMMC to handle the event
properly.  Tests were conducted under both idle conditions and active
read/write operations.

Oleksij Rempel (6):
  mmc: core: Handle undervoltage events and register regulator notifiers
  mmc: core: make mmc_interrupt_hpi() global
  mmc: core: refactor _mmc_suspend() for undervoltage handling
  mmc: core: add undervoltage handler for MMC/eMMC devices
  mmc: block: abort requests and suppress errors after undervoltage
    shutdown
  mmc: sdhci: prevent command execution after undervoltage shutdown

 drivers/mmc/core/block.c     |   2 +-
 drivers/mmc/core/core.c      |  20 ++++++
 drivers/mmc/core/core.h      |   2 +
 drivers/mmc/core/mmc.c       | 101 ++++++++++++++++++++++++------
 drivers/mmc/core/mmc_ops.c   |   2 +-
 drivers/mmc/core/mmc_ops.h   |   1 +
 drivers/mmc/core/queue.c     |   2 +-
 drivers/mmc/core/regulator.c | 115 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     |   9 +++
 include/linux/mmc/host.h     |   9 +++
 10 files changed, 241 insertions(+), 22 deletions(-)

--
2.39.5


