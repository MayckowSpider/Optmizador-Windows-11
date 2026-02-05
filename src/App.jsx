import React, { useState, useEffect } from 'react';
import {
    Zap,
    ShieldCheck,
    Trash2,
    Cpu,
    Gamepad2,
    Activity,
    Settings,
    ChevronRight,
    CheckCircle2,
    Clock,
    HardDrive,
    History,
    RotateCcw,
    Database,
    AlertTriangle
} from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

const App = () => {
    const [activeTab, setActiveTab] = useState('dashboard');
    const [optimizing, setOptimizing] = useState(false);
    const [progress, setProgress] = useState(0);
    const [lastOptimized, setLastOptimized] = useState('Nunca');
    const [status, setStatus] = useState('');

    const optimizeSystem = async () => {
        setOptimizing(true);
        setProgress(0);

        const steps = [
            { label: 'Limpando arquivos temporários...', icon: '🗑️' },
            { label: 'Otimizando privacidade do W11...', icon: '🛡️' },
            { label: 'Aplicando modo de alta performance...', icon: '🚀' },
            { label: 'Gerindo Processos e Serviços...', icon: '⚡' },
            { label: 'Removendo Bloatware...', icon: '📦' },
            { label: 'Rodando Manutenção Pro (Segura)...', icon: '🔧' },
            { label: 'Otimizando Rede e Latência...', icon: '🌐' },
            { label: 'Removendo notificações e dicas...', icon: '🍃' },
            { label: 'Finalizando ajustes finais...', icon: '✅' }
        ];

        const stepIncrement = 100 / steps.length;
        for (let i = 0; i < steps.length; i++) {
            setStatus(steps[i].label);
            const startProgress = i * stepIncrement;
            for (let p = 0; p <= stepIncrement; p++) {
                setProgress(Math.round(startProgress + p));
                await new Promise(r => setTimeout(r, 30));
            }
        }

        setOptimizing(false);
        setLastOptimized(new Date().toLocaleTimeString());
        setStatus('Sistema Otimizado!');
    };

    const menuItems = [
        { id: 'dashboard', icon: Activity, label: 'Dashboard' },
        { id: 'cleanup', icon: Trash2, label: 'Limpeza' },
        { id: 'performance', icon: Gamepad2, label: 'Gaming Mode' },
        { id: 'privacy', icon: ShieldCheck, label: 'Privacidade' },
        { id: 'backup', icon: History, label: 'Backup & Restore' },
        { id: 'settings', icon: Settings, label: 'Ajustes' },
    ];

    const stats = [
        { label: 'Uso de CPU', value: '12%', color: 'var(--accent-primary)' },
        { label: 'RAM Disponível', value: '4.2 GB', color: 'var(--accent-purple)' },
        { label: 'Temp. Disco', value: '34°C', color: 'var(--success)' },
    ];

    return (
        <div className="container" style={{ display: 'flex', gap: '30px', minHeight: '90vh' }}>
            {/* Sidebar Navigation */}
            <aside className="glass" style={{ width: '280px', padding: '30px', display: 'flex', flexDirection: 'column' }}>
                <div style={{ marginBottom: '40px', display: 'flex', alignItems: 'center', gap: '15px' }}>
                    <div className="flex-center" style={{ width: '45px', height: '45px', borderRadius: '12px', background: 'linear-gradient(135deg, var(--accent-primary), var(--accent-purple))' }}>
                        <Zap size={24} color="#000" />
                    </div>
                    <h2 style={{ fontSize: '1.2rem' }}>WinOptimize <span className="gradient-text">Pro</span></h2>
                </div>

                <nav style={{ flex: 1 }}>
                    {menuItems.map((item) => (
                        <button
                            key={item.id}
                            onClick={() => setActiveTab(item.id)}
                            style={{
                                width: '100%',
                                display: 'flex',
                                alignItems: 'center',
                                gap: '15px',
                                padding: '15px',
                                marginBottom: '10px',
                                border: 'none',
                                background: activeTab === item.id ? 'rgba(255, 255, 255, 0.1)' : 'transparent',
                                color: activeTab === item.id ? 'var(--accent-primary)' : 'var(--text-muted)',
                                borderRadius: '14px',
                                cursor: 'pointer',
                                transition: 'all 0.3s ease',
                                textAlign: 'left',
                                fontWeight: activeTab === item.id ? '600' : '400'
                            }}
                            className="glass-hover"
                        >
                            <item.icon size={20} />
                            <span style={{ fontSize: '0.95rem' }}>{item.label}</span>
                            {activeTab === item.id && <motion.div layoutId="active" style={{ marginLeft: 'auto', width: '4px', height: '4px', borderRadius: '50%', background: 'var(--accent-primary)' }} />}
                        </button>
                    ))}
                </nav>

                <div className="glass" style={{ padding: '20px', background: 'rgba(255,255,255,0.03)', marginTop: '20px' }}>
                    <p style={{ color: 'var(--text-muted)', fontSize: '0.75rem', marginBottom: '8px' }}>Última Otimização</p>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                        <Clock size={14} color="var(--accent-primary)" />
                        <span style={{ fontSize: '0.85rem', fontWeight: 'bold' }}>{lastOptimized}</span>
                    </div>
                </div>
            </aside>

            {/* Main Content Area */}
            <main style={{ flex: 1 }}>
                <header style={{ marginBottom: '40px', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                    <div>
                        <h1 style={{ fontSize: '2.5rem', marginBottom: '8px' }}>Bem-vindo, <span className="gradient-text">User</span></h1>
                        <p style={{ color: 'var(--text-muted)' }}>Status do sistema: <span style={{ color: 'var(--success)' }}>Excelente</span></p>
                    </div>

                    <button
                        className="btn-primary"
                        onClick={optimizeSystem}
                        disabled={optimizing}
                        style={{ display: 'flex', alignItems: 'center', gap: '10px', padding: '15px 30px', fontSize: '1rem' }}
                    >
                        {optimizing ? 'Otimizando...' : 'Otimizar Agora'}
                        <Zap size={18} fill="currentColor" />
                    </button>
                </header>

                <AnimatePresence mode="wait">
                    {/* Dashboard Content */}
                    {activeTab === 'dashboard' && (
                        <motion.div key="dashboard" initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }} transition={{ duration: 0.3 }}>
                            {/* Real-time Progress Bar */}
                            <AnimatePresence>
                                {optimizing && (
                                    <motion.div
                                        initial={{ opacity: 0, height: 0 }}
                                        animate={{ opacity: 1, height: 'auto' }}
                                        exit={{ opacity: 0, height: 0 }}
                                        className="glass"
                                        style={{ marginBottom: '30px', padding: '25px', overflow: 'hidden' }}
                                    >
                                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '15px' }}>
                                            <span style={{ fontWeight: '600' }}>{status}</span>
                                            <span style={{ color: 'var(--accent-primary)', fontWeight: 'bold' }}>{progress}%</span>
                                        </div>
                                        <div style={{ width: '100%', height: '8px', background: 'rgba(255,255,255,0.1)', borderRadius: '10px', overflow: 'hidden' }}>
                                            <motion.div
                                                style={{ height: '100%', background: 'linear-gradient(90deg, var(--accent-primary), var(--accent-purple))' }}
                                                initial={{ width: 0 }}
                                                animate={{ width: `${progress}%` }}
                                            />
                                        </div>
                                    </motion.div>
                                )}
                            </AnimatePresence>

                            {/* Stats Grid */}
                            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '20px', marginBottom: '30px' }}>
                                {stats.map((stat, i) => (
                                    <div key={i} className="glass glass-hover" style={{ padding: '25px', borderLeft: `4px solid ${stat.color}` }}>
                                        <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', marginBottom: '10px' }}>{stat.label}</p>
                                        <h3 style={{ fontSize: '1.8rem', color: stat.color }}>{stat.value}</h3>
                                    </div>
                                ))}
                            </div>

                            {/* Main Action Cards */}
                            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '25px' }}>
                                <div className="glass glass-hover" style={{ padding: '30px', cursor: 'pointer' }}>
                                    <div className="flex-center" style={{ width: '50px', height: '50px', borderRadius: '15px', background: 'rgba(0, 242, 254, 0.1)', marginBottom: '20px' }}>
                                        <Trash2 color="var(--accent-primary)" />
                                    </div>
                                    <h3 style={{ marginBottom: '10px' }}>Limpeza de Disco</h3>
                                    <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', lineHeight: '1.6' }}>
                                        Remove arquivos temporários e cache para liberar espaço.
                                    </p>
                                    <div style={{ marginTop: '20px', display: 'flex', alignItems: 'center', color: 'var(--accent-primary)', fontWeight: '600', gap: '5px', fontSize: '0.85rem' }}>
                                        Cleaner.ps1 <ChevronRight size={16} />
                                    </div>
                                </div>

                                <div className="glass glass-hover" style={{ padding: '30px', cursor: 'pointer' }}>
                                    <div className="flex-center" style={{ width: '50px', height: '50px', borderRadius: '15px', background: 'rgba(112, 0, 255, 0.1)', marginBottom: '20px' }}>
                                        <ShieldCheck color="var(--accent-purple)" />
                                    </div>
                                    <h3 style={{ marginBottom: '10px' }}>Privacidade</h3>
                                    <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', lineHeight: '1.6' }}>
                                        Desativa telemetria e rastreadores do Windows.
                                    </p>
                                    <div style={{ marginTop: '20px', display: 'flex', alignItems: 'center', color: 'var(--accent-purple)', fontWeight: '600', gap: '5px', fontSize: '0.85rem' }}>
                                        Privacy.ps1 <ChevronRight size={16} />
                                    </div>
                                </div>

                                <div className="glass glass-hover" style={{ padding: '30px', cursor: 'pointer' }}>
                                    <div className="flex-center" style={{ width: '50px', height: '50px', borderRadius: '15px', background: 'rgba(255, 170, 0, 0.1)', marginBottom: '20px' }}>
                                        <Zap color="#FFAA00" />
                                    </div>
                                    <h3 style={{ marginBottom: '10px' }}>Processos</h3>
                                    <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', lineHeight: '1.6' }}>
                                        Otimiza serviços e prioridade de CPU para apps ativos.
                                    </p>
                                    <div style={{ marginTop: '20px', display: 'flex', alignItems: 'center', color: '#FFAA00', fontWeight: '600', gap: '5px', fontSize: '0.85rem' }}>
                                        Processes.ps1 <ChevronRight size={16} />
                                    </div>
                                </div>
                            </div>
                        </motion.div>
                    )}

                    {/* Backup & Restore Tab */}
                    {activeTab === 'backup' && (
                        <motion.div key="backup" initial={{ opacity: 0, x: 20 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: -20 }} transition={{ duration: 0.3 }}>
                            <div className="glass" style={{ padding: '40px', maxWidth: '800px' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '20px', marginBottom: '30px' }}>
                                    <div className="flex-center" style={{ width: '60px', height: '60px', borderRadius: '20px', background: 'rgba(255, 255, 255, 0.05)' }}>
                                        <History size={30} color="var(--accent-primary)" />
                                    </div>
                                    <div>
                                        <h2 style={{ fontSize: '1.8rem' }}>Backup & Restauração</h2>
                                        <p style={{ color: 'var(--text-muted)' }}>Gerencie seus pontos de retorno com segurança.</p>
                                    </div>
                                </div>

                                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
                                    <div className="glass glass-hover" style={{ padding: '25px', background: 'rgba(255,255,255,0.02)' }}>
                                        <h3 style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '15px' }}>
                                            <Database size={18} color="var(--accent-primary)" />
                                            Ponto de Restauração
                                        </h3>
                                        <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)', marginBottom: '20px' }}>
                                            Cria uma imagem do estado atual do sistema Windows. Altamente recomendado antes de qualquer alteração.
                                        </p>
                                        <button className="btn-primary" style={{ width: '100%', padding: '12px' }}>
                                            Criar Backup do Sistema
                                        </button>
                                    </div>

                                    <div className="glass glass-hover" style={{ padding: '25px', background: 'rgba(255,255,255,0.02)' }}>
                                        <h3 style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '15px' }}>
                                            <RotateCcw size={18} color="var(--accent-purple)" />
                                            Reverter Alterações
                                        </h3>
                                        <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)', marginBottom: '20px' }}>
                                            Restaura as chaves de registro para os padrões do Windows 11 sem precisar de um reboot completo.
                                        </p>
                                        <button className="btn-secondary" style={{ width: '100%', padding: '12px' }}>
                                            Restaurar Padrões
                                        </button>
                                    </div>
                                </div>

                                <div className="glass" style={{ marginTop: '20px', padding: '20px', border: '1px solid rgba(255, 170, 0, 0.2)', background: 'rgba(255, 170, 0, 0.02)' }}>
                                    <div style={{ display: 'flex', gap: '15px' }}>
                                        <AlertTriangle color="#FFAA00" size={24} style={{ flexShrink: 0 }} />
                                        <div>
                                            <p style={{ fontWeight: 'bold', color: '#FFAA00', marginBottom: '5px' }}>Atenção</p>
                                            <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)', lineHeight: '1.5' }}>
                                                Se algo parar de funcionar (como Wi-Fi ou Pesquisa), use a Restauração do Sistema do Windows (`rstrui.exe`). Nosso botão de "Restaurar Padrões" cobre apenas chaves de registro alteradas por este app.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </motion.div>
                    )}
                </AnimatePresence>
            </main>
        </div>
    );
};

export default App;
