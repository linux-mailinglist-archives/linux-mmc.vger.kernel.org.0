Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D9C21C51A
	for <lists+linux-mmc@lfdr.de>; Sat, 11 Jul 2020 18:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgGKQQM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 11 Jul 2020 12:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgGKQQM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 11 Jul 2020 12:16:12 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F5F2075F;
        Sat, 11 Jul 2020 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594484172;
        bh=+BSGlLJBW8PWM3+BVUVf02ZgKAnl9LalQ3SOruYoT0c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KYzV8/ZHzQUxOw0I+CMVF1wiT7uZvnhyd5eD8mS4uTYghTKVvoI1GyIKVUC5Xsr9w
         hxDLexH9X30DWfBvlRbOmueols7wGfzk83ckeBTFqoqPdjxkSV7VkCQc5YavKKQX6I
         pbm6ixyLjgSmjs1abybkS1DG68Ot/UF/1b2oLr8Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200709195706.12741-2-eajames@linux.ibm.com>
References: <20200709195706.12741-1-eajames@linux.ibm.com> <20200709195706.12741-2-eajames@linux.ibm.com>
Subject: Re: [PATCH 1/2] clk: AST2600: Add mux for EMMC clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, andrew@aj.id.au, joel@jms.id.au,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        mturquette@baylibre.com, eajames@linux.ibm.com
To:     Eddie James <eajames@linux.ibm.com>, linux-clk@vger.kernel.org
Date:   Sat, 11 Jul 2020 09:16:11 -0700
Message-ID: <159448417133.1987609.8669229169177662950@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Eddie James (2020-07-09 12:57:05)
> The EMMC clock can be derived from either the HPLL or the MPLL. Register
> a clock mux so that the rate is calculated correctly based upon the
> parent.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---

Applied to clk-fixes
