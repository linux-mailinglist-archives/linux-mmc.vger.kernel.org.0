Return-Path: <linux-mmc+bounces-7066-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D75CADAD62
	for <lists+linux-mmc@lfdr.de>; Mon, 16 Jun 2025 12:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C157A9305
	for <lists+linux-mmc@lfdr.de>; Mon, 16 Jun 2025 10:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC929B229;
	Mon, 16 Jun 2025 10:29:23 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C72882D6
	for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2025 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069763; cv=none; b=qfpwSsBgR3jal/dm2eXsvISxI+14xQ1WeQ1jqGgaU00tYMT/8Q67HAp8saAqOINNxpBtEmhTD533LiMLwchnpbfwY+crrsujqGLHA5RUE2PJuOM7n5U4khVY0IfPIFF99sMYwTJ7NIG17lozBwO8X/cPyW8ICr0fSmWn0McxKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069763; c=relaxed/simple;
	bh=rZTlMbXrS/7Wnsh09jqcevFaRDj2xlqvTak0vv1H7M4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZeYcZY+cJGvWRQtBQHf/Cpp7iDTjhsF1WAf/VNQeH6/V0+VeQPv77SX4ikOGU/nTVVwj3EAcKw9XtRdtiHgrrnilhLsc11CSLDR2q5pzANzoTZkOHvD/ifV2pE9G3HJqjmArvwUMjLrMayQsbVQh7W0YwW+i/YJtL1Ex35x/l3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uR75b-0008Sz-09; Mon, 16 Jun 2025 12:29:19 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uR75a-003n2w-0I;
	Mon, 16 Jun 2025 12:29:18 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uR75a-0072Ih-04;
	Mon, 16 Jun 2025 12:29:18 +0200
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
	Christian Loehle <christian.loehle@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <Avri.Altman@sandisk.com>
Subject: [PATCH v6 0/4] mmc: handle undervoltage events and prevent eMMC corruption
Date: Mon, 16 Jun 2025 12:29:13 +0200
Message-Id: <20250616102917.1677116-1-o.rempel@pengutronix.de>
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

changes v6:
- Rewrite commit message to be more technical per reviewer feedback.
- Address race conditions by using __mmc_stop_host() instead of only
  claiming the host in the undervoltage handler.
- Move notifier registration from mmc_regulator_get_supply() to the end of
  a successful card initialization in mmc_attach_mmc(), ensuring it only
  runs for capable cards.
- Centralize notifier unregistration in mmc_remove_card() to correctly
  handle all card removal and error paths.
- Add 'undervoltage_notify_registered' flag to struct mmc_host to
  reliably track the notifier state.
- Consolidate multiple notifier callbacks into a single, generic handler.
- Remove premature notifier support for vqmmc and vqmmc2 regulators.
- Move INIT_WORK() for the undervoltage workqueue to mmc_alloc_host().
changes v5:
- Rebased on top of mmc/next after introduction of enum mmc_poweroff_type
- Replaced boolean undervoltage parameter with MMC_POWEROFF_UNDERVOLTAGE
- Dropped unused __mmc_resume() helper
- Updated commit messages accordingly
changes v4:
- drop HPI and SDHCI related patches

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

Oleksij Rempel (4):
  mmc: core: Add infrastructure for undervoltage handling
  mmc: core: Add MMC_POWEROFF_UNDERVOLTAGE support in _mmc_suspend()
  mmc: core: add undervoltage handler for MMC/eMMC devices
  mmc: block: abort requests and suppress errors after undervoltage
    shutdown

 drivers/mmc/core/block.c     |  2 +-
 drivers/mmc/core/bus.c       |  5 ++
 drivers/mmc/core/core.c      | 33 +++++++++++++
 drivers/mmc/core/core.h      |  2 +
 drivers/mmc/core/host.c      |  3 ++
 drivers/mmc/core/mmc.c       | 95 +++++++++++++++++++++++++++++++++---
 drivers/mmc/core/queue.c     |  2 +-
 drivers/mmc/core/regulator.c | 82 +++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     | 10 ++++
 9 files changed, 226 insertions(+), 8 deletions(-)

--
2.39.5


