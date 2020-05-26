Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB41B0141
	for <lists+linux-mmc@lfdr.de>; Mon, 20 Apr 2020 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgDTF5p (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 20 Apr 2020 01:57:45 -0400
Received: from mail.nic.cz ([217.31.204.67]:40718 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgDTF5p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Apr 2020 01:57:45 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 55721140E72;
        Mon, 20 Apr 2020 07:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587362264; bh=ILuoSgtZOB2XYW8YGwMliQcV993u0Qd2YOIPZ7b7pdg=;
        h=Date:From:To;
        b=KBJD2wWfrxV2F9Qqc8Mk0dJwtlZFq9mhGaE0gapF1qFsnbiQx7SbBgklinsN5yLJL
         R10qr7JglCpHivjQDedhuXzkSKI7m9DyS1PRSQBDPAEWTqIVdALR7GE/fPrzRtbgrb
         2Fm6lTqS1EWMyDdjoZ3OXpJaU0xeDIfqVeem7hB8=
Date:   Mon, 20 Apr 2020 07:57:43 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     linux-mmc@vger.kernel.org
Cc:     Zhoujie Wu <zjwu@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: fix annoying 1.8V regulator warning
Message-ID: <20200420075743.3b6ed229@nic.cz>
In-Reply-To: <20200419053746.22443-1-marek.behun@nic.cz>
References: <20200419053746.22443-1-marek.behun@nic.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,URIBL_BLOCKED,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 19 Apr 2020 07:37:46 +0200
Marek Beh=C3=BAn <marek.behun@nic.cz> wrote:

> For some reason the Host Control2 register of the Xenon SDHCI controller
> sometimes reports the bit representing 1.8V signaling as 0 when read
> after it was written as 1. Subsequent read reports 1.
>=20
> This causes the sdhci_start_signal_voltage_switch function to report
>   1.8V regulator output did not become stable
>=20
> When CONFIG_PM is enabled, the host is suspended and resumend many
> times, and in each resume the switch to 1.8V is called, and so the
> kernel log reports this message annoyingly often.
>=20
> Do an empty read of the Host Control2 register in Xenon's
> .voltage_switch method to circumvent this.
>=20
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>

I should probably add a Fixes tag here so that it gets backported to
stable versions.
BTW this happens on Turris Mox.
