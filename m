Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D5A47A52
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfFQG6P (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 02:58:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFQG6P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 02:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/+2jnSophwa25P5mcJFi9TyF+a6lLsffKgVq1/9LKi8=; b=WQtRVz+s2tQWbdFjUvtv4FEip
        U9vNcMEiZd71e4KemxAC+0ZsDq5DdNFQ2jxTwiOoiTiULZgVaiQK2vskNZNKlir1+P3d370izIKz4
        DCROzyFd4iJkxzKT6dDteTe8GlYXfD0DxCIUAaYluKsoDsb2ESFr+ssKBJMTdNYW8QXoUKUgZysYg
        IHLdgC4BvwNegSOznAKeT9U96h9cWXp1OKMTF6fPVtmwxu4t0FLUxjthY19JVohhqJccxGA67YKJf
        aTGhNOjQiQw3acN18n4kt5WLhErm2mpjW4J/cfprljUIDlHdOhqTr6rS11f6yQnoHklGxjiYAvS4B
        IAlINB4hQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hclah-0004uM-HY; Mon, 17 Jun 2019 06:58:07 +0000
Date:   Sun, 16 Jun 2019 23:58:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Angelo Dureghello <angelo@sysam.it>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mmc: add Coldfire esdhc support
Message-ID: <20190617065807.GA17948@infradead.org>
References: <20190616204823.32758-1-angelo@sysam.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616204823.32758-1-angelo@sysam.it>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Jun 16, 2019 at 10:48:21PM +0200, Angelo Dureghello wrote:
> This driver has been developed as a separate module starting
> from the similar sdhci-esdhc-fls.c.
> Separation has been mainly driven from change in endianness.

Can't we have a way to define the endianess at build or even runtime?
We have plenty of that elsewhere in the kernel.
