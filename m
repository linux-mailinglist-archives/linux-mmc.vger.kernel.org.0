Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F6C2C24A9
	for <lists+linux-mmc@lfdr.de>; Tue, 24 Nov 2020 12:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbgKXLhg (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 24 Nov 2020 06:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731640AbgKXLhf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 06:37:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF8DC0613D6;
        Tue, 24 Nov 2020 03:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ikFs6W6RIrqT3FutCVCXxvjhSuQBXFHIV/NVbFH43V8=; b=WatDSBL3PWnNbzhkqZCNit+hxQ
        rgUctPs3viclqZ2fAfyGGDLZb4ZhsEXXUUJJ7OxGCjvAoJVVCOrFgS2MHX2dCjJQp9qqEptTXAH6j
        RllhfyaOtPO3vhtWEq4IPenMH4bG8OQiCaygDwrdA/q6/PKHtKCCiU5u+4e3S43uvp7/zWCER8cSg
        UZTrbmuzD8Hyiq9iHxDZrPZBbCijjurcI6Kw4gIP1Vi5imwCXISKNX6V9BCkVXUmKs/WKLBt4M0JX
        zP0ldSWhp34xbB+GJ6HhDfgTpxaxPBvKhbO8WrNMTIBMSa8W5fur3wgpI+Babb1u3+e2edSAO+Imx
        K6ngEM4w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khWdM-0007vU-6g; Tue, 24 Nov 2020 11:37:20 +0000
Date:   Tue, 24 Nov 2020 11:37:20 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     ulf.hansson@linaro.org, keescook@chromium.org, ccross@android.com,
        tony.luck@intel.com, sgoutham@marvell.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        outgoing2/0000-cover-letter.patch@mx0b-0016f401.pphosted.com
Subject: Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on pstore/blk
Message-ID: <20201124113720.GA30440@infradead.org>
References: <20201123111925.28999-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123111925.28999-1-bbudiredla@marvell.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Please hold this off for now.  I have a major rewrite of the pstore/blk
interface pending..
